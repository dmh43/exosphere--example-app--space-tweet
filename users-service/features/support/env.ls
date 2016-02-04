module.exports = ->

  @set-default-timeout 2000


  @After ->
    @exocomm?.close!
    @process?.kill!
