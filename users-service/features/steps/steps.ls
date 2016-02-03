require! {
  '../support/dim-console'
  'chai' : {expect}
  'livescript'
  'observable-process' : ObservableProcess
  'record-http' : HttpRecorder
  'request'
  'wait' : {wait-until}
}


module.exports = ->

  @Given /^an ExoComm server running at port (\d+)$/, (@exocomm-port, done) ->
    @exocomm = new HttpRecorder!listen @exocomm-port, done


  @Given /^an instance of this service running at port (\d+)$/, (@service-port, done) ->
    @process = new ObservableProcess("node_modules/.bin/exo-js run --port #{@service-port} --exocomm-port #{@exocomm-port}",
                                     console: dim-console
                                     verbose: yes)
      ..wait 'online at port', done


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


  @Then /^the service replies with "([^"]*)" and the payload:$/, (command, payload, done) ->
    condition = ~> @exocomm.calls.length is 1
    wait-until condition, ~>
      call = @exocomm.calls[0]
      expect(call.url).to.equal "http://localhost:#{@exocomm-port}/send/#{command}"
      expect(call.body.response-to).to.equal '123'
      eval livescript.compile "json-payload = {\n#{payload}\n}", bare: yes, header: no
      expect(call.body.payload).to.eql json-payload
      done!
