require! {
  '../support/dim-console'
  'chai' : {expect}
  'is-regexp'
  'jsdiff-console'
  'livescript'
  'nitroglycerin' : N
  'observable-process' : ObservableProcess
  'record-http' : HttpRecorder
  'request'
  'wait' : {wait-until}
}


module.exports = ->

  @Given /^an ExoComm server running at port (\d+)$/, (@exocomm-port, done) ->
    @exocomm = new HttpRecorder!listen @exocomm-port, done


  @Given /^a fresh instance of this service running at port (\d+)$/, (@service-port, done) ->
    @process = new ObservableProcess("node_modules/.bin/exo-js run --port #{@service-port} --exocomm-port #{@exocomm-port}",
                                     console: dim-console
                                     verbose: yes)
      ..wait 'online at port', ~>
        request-data =
          url: "http://localhost:#{@service-port}/run/reset",
          method: 'POST'
          body:
            requestId: '123'
          json: yes
        request request-data, N ~>
          condition = ~> @exocomm.calls.length is 1
          wait-until condition, ~>
            @exocomm.reset!
            done!



  @When /^sending the command "([^"]*)"$/, (command, done) ->
    request-data =
      url: "http://localhost:#{@service-port}/run/#{command}",
      method: 'POST'
      body:
        requestId: '123'
      json: yes
    request request-data, done


  @When /^sending the command "([^"]*)" with the payload:$/, (command, payload, done) ->
    eval livescript.compile "json-payload = {\n#{payload}\n}", bare: yes, header: no
    request-data =
      url: "http://localhost:#{@service-port}/run/#{command}",
      method: 'POST'
      body:
        requestId: '123'
        payload: json-payload
      json: yes
    request request-data, done


  @Then /^the service contains the user accounts:$/, (table, done) ->
    request-data =
      url: "http://localhost:#{@service-port}/run/users.list",
      method: 'POST'
      body:
        requestId: '123'
      json: yes
    request request-data, N ~>
      condition = ~> @exocomm.calls.length is 2
      wait-until condition, ~>
        call = @exocomm.calls[1]
        actual-users = call.body.payload.users
        for user in actual-users
          delete user.id
        expected-users = [{[key.to-lower-case!, value] for key, value of user} for user in table.hashes!]
        jsdiff-console actual-users, expected-users, done


  @Then /^the service replies with "([^"]*)" and the payload:$/, (command, payload, done) ->
    condition = ~> @exocomm.calls.length is 1
    wait-until condition, ~>
      call = @exocomm.calls[0]
      expect(call.url).to.equal "http://localhost:#{@exocomm-port}/send/#{command}"
      expect(call.body.response-to).to.equal '123'
      eval livescript.compile "json-payload = {\n#{payload}\n}", bare: yes, header: no
      for key, value of json-payload
        delete json-payload[key]
        delete call.body.payload[key]
      jsdiff-console call.body.payload, json-payload, done
