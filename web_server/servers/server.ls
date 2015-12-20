# This is the main server file.
#
# It parses the command line and instantiates the two servers for this app:
# * app_server: HTML server
# * asset_server: serves assets
require! {
  'http'
  '../servers/html_server.ls' : app-server
  '../servers/asset_server.ls' : asset-server
}
debug = require('debug')('web:server')


server = http.createServer app-server
server.on 'error', (error) ->
  | error.syscall isnt 'listen'  =>  throw error

  console.error switch error.code
  | 'EACCES'      =>  'Port requires elevated privileges'
  | 'EADDRINUSE'  =>  'Port is already in use'
  | _             =>  error
  process.exit 1

server.on 'listening', ->
  debug "web server online at port #{server.address!port}"


server.listen parse-int(process.env.PORT or '3000')

asset-server.listen 8080, 'localhost', ->
  debug 'asset server online at port 8080'
