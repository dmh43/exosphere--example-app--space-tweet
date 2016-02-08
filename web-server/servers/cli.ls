# This is the main server file.
#
# It parses the command line and instantiates the two servers for this app:
# * app_server: HTML server
# * asset_server: serves assets
require! {
  'chalk' : {red}
  '../servers/html-server.ls' : HtmlServer
  '../servers/asset-server.ls' : AssetServer
}
debug = require('debug')('web:server')


server = new HtmlServer
  ..on 'listening', -> debug "html server online at port #{server.port!}"
  ..on 'error', (err) -> console.log red err
  ..listen parse-int(process.env.PORT or '3000')


asset-server = new AssetServer
  ..listen 8080, 'localhost', ->
    debug 'asset server online at port 8080'
