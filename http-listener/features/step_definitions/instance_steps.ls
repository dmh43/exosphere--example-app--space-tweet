HttpListener = require '../../http-listener.ls'
{expect} = require 'chai'


module.exports = ->

  @Given /^a http\-listener instance listening on port (\d+)$/, (port, done) ->
    @instance = new HttpListener!listen port, done


  @Then /^retrieving the recorded calls yields:$/, (text) ->
    expect(@instance.calls).to.eql eval text
