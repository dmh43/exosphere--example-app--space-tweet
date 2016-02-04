require! {
  '../support/dim-console'
  'chai' : {expect}
  'exocomm-mock' : ExoCommMock
  'jsdiff-console'
  'livescript'
  'nitroglycerin' : N
  'observable-process' : ObservableProcess
  'record-http' : HttpRecorder
  'request'
  '../support/remove-ids' : {remove-ids}
  'wait' : {wait-until}
}


module.exports = ->

  @Given /^an ExoComm server running at port (\d+)$/, (port, done) ->
    @exocomm = new ExoCommMock
      ..listen port, done


  @Given /^an instance of this service running at port (\d+)$/, (@service-port, done) ->
    @exocomm.register-service name: 'users', port: @service-port
    @process = new ObservableProcess("node_modules/.bin/exo-js run --port #{@service-port} --exocomm-port #{@exocomm.port}",
                                     console: dim-console
                                     verbose: yes)
      ..wait "online at port #{@service-port}", ~>
        @exocomm.send-command service: 'users', name: 'reset'
        @exocomm.wait-until-receive ~>
            @exocomm.reset!
            done!


  @Given /^the service contains the users:$/, (table, done) ->
    for user in table.hashes!
      @exocomm
        ..send-command service: 'users', name: 'users.create', payload: {name: user.NAME}
        ..wait-until-receive ~>
          @exocomm.reset!
          done!



  @When /^sending the command "([^"]*)"$/, (command) ->
    @exocomm.send-command service: 'users', name: command


  @When /^sending the command "([^"]*)" with the payload:$/, (command, payload) ->
    eval livescript.compile "payload-json = {\n#{payload}\n}", bare: true, header: no
    @exocomm.send-command service: 'users', name: command, payload: payload-json


  @Then /^the service contains the user accounts:$/, (table, done) ->
    @exocomm
      ..send-command service: 'users', name: 'users.list'
      ..wait-until-receive ~>
        actual-users = remove-ids @exocomm.received-commands![0].payload.users
        expected-users = [{[key.to-lower-case!, value] for key, value of user} for user in table.hashes!]
        jsdiff-console actual-users, expected-users, done


  @Then /^the service replies with "([^"]*)" and the payload:$/, (command, payload, done) ->
    @exocomm.wait-until-receive ~>
      actual-payload = @exocomm.received-commands![0].payload
      eval livescript.compile "expected-payload = {\n#{payload}\n}", bare: yes, header: no
      jsdiff-console remove-ids(actual-payload), remove-ids(expected-payload), done
      @exocomm.reset!
