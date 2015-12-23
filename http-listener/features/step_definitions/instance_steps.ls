HttpListener = require '../../http-listener.ls'
{expect} = require 'chai'
{obj-to-lists, map, lists-to-obj} = require 'prelude-ls'


lowercase-keys = (hash) ->
  result = {}
  for key, value of hash
    result[key.to-lower-case!] = value
  result


module.exports = ->

  @Given /^a http\-listener instance listening on port (\d+)$/, (port, done) ->
    @instance = new HttpListener!listen port, done


  @Then /^retrieving the recorded calls yields:$/, (text) ->
    expect(@instance.calls).to.eql eval text
