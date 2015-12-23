module.exports = ->

  @set-default-timeout 500

  @After (scenario) ->
    @instance?.close!
