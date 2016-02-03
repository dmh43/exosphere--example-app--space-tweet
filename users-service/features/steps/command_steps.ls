module.exports = ->

  @When /^sending the command "([^"]*)" with the payload:$/, (command, payload, done) ->
    @send-command command, payload, done
