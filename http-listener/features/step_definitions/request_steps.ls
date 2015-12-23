require! \request
{expect} = require 'chai'


module.exports = ->

  @When /^I send a GET request to (.+)$/, (url, done) ->
    request url, (@error, @response, @body) ~>
      done!


  @Then /^the call succeeds$/, ->
    expect(@error).to.be.null
    expect(@response.status-code).to.equal 200
