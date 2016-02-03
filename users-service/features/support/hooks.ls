require! {
  'exosphere-messaging-dev-server'
  \nitroglycerin : N
  \portfinder
}


module.exports = ->

  @register-handler 'BeforeFeatures', (event, done) ->
    portfinder.get-port N (err, port) ->
      exosphere-messaging-dev-server.listen port, ->
        console.log 'listening'
        done!

  @register-handler 'AfterFeatures', (event, done) ->
    console.log 'AFTER ALL'
    done!
