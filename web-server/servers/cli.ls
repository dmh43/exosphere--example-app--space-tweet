# This is the main server file.
#
# It parses the command line and instantiates the two servers for this app:
# * app_server: HTML server
# * asset_server: serves assets
require! {
  '../servers/html-server.ls' : HtmlServer
  '../servers/asset-server.ls'
}
debug = require('debug')('web:server')


on-server-error = (error) ->
  throw new Error switch error.code
  | 'EACCES'      =>  'Port requires elevated privileges'
  | 'EADDRINUSE'  =>  'Port is already in use'
  | _             =>  error


server = new HtmlServer
  ..on 'listening', -> debug "html server online at port #{server.port!}"
  ..on 'error', on-server-error
  ..listen parse-int(process.env.PORT or '3000')


asset-server.listen 8080, 'localhost', ->
  debug 'asset server online at port 8080'
