module.exports = ->

  @set-default-timeout 1500


  @After ->
    @exocomm?.close!
    @process?.kill!
