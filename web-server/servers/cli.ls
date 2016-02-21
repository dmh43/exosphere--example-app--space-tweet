# This is the main server file.
#
# It parses the command line and instantiates the two servers for this app:
# * app_server: HTML server
# * asset_server: serves assets
require! {
  'async'
  'chalk' : {cyan, dim, green, red}
  'docopt' : {docopt}
  'exorelay' : ExoRelay
  '../package.json' : {name, version}
  '../servers/html-server.ls' : HtmlServer
  '../servers/asset-server.ls' : AssetServer
}
debug = require('debug')('web:server')


console.log dim "SpaceTweet web server #{version}\n"


global.config = {}

start-html-server = (done) ->
  html-server = new HtmlServer
    ..on 'error', (err) -> console.log red err
    ..on 'listening', ->
      console.log "#{green 'HTML server'} online at port #{cyan html-server.port!}"
      done!
    ..listen 3000


start-asset-server = (done) ->
  asset-server = new AssetServer 3001
    ..listen ->
      console.log "#{green 'asset server'} online at port #{cyan asset-server.port}"
      global.config['asset-port'] = asset-server.port
      done!


start-exorelay = (done) ->
  global.exorelay = new ExoRelay service-name: process.env.SERVICE_NAME, exocomm-port: process.env.EXOCOMM_PORT
    ..on 'error', (err) -> console.log red err
    ..on 'online', (port) ->
      console.log "#{green 'ExoRelay'} online at port #{cyan port}"
      done!
    ..listen process.env.EXORELAY_PORT


async.parallel [start-html-server,
                start-asset-server,
                start-exorelay], (err) ->
  console.log green 'all systems go'
