HttpListener = require '../../http-listener.ls'
{expect} = require 'chai'
require! \request


module.exports = ->

  @Given /^(?:setting up another|a) http\-listener instance listening on port (\d+)$/, (port, done) ->
    @instance = new HttpListener!listen port, done


  @When /^a GET request to (.+)$/, (url, done) ->
    request url, (error, response, body) ~>
      expect(error).to.be.null
      expect(response.status-code).to.equal 200
      done!


  @When /^closing this instance$/, ->
    @instance.close!


  @Then /^requests to ([^ ]+) are no longer possible/, (url, done) ->
    request url, (error, response, body) ~>
      expect(error.code).to.equal 'ECONNREFUSED'
      done!


  @Then /^the recorded calls are:$/, (text) ->
    expect(@instance.calls).to.eql eval text
