!function World

  # The mock messaging server
  @messaging = {}

  @send-command = (command, payload, done) ->
    console.log "Sending #{command}"
    done!


module.exports = ->
  @World = World
