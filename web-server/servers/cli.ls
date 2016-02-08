# This is the main server file.
#
# It parses the command line and instantiates the two servers for this app:
# * app_server: HTML server
# * asset_server: serves assets
require! {
  'async'
  'chalk' : {cyan, dim, green, red}
  'docopt' : {docopt}
  '../package.json' : {name, version}
  '../servers/html-server.ls' : HtmlServer
  '../servers/asset-server.ls' : AssetServer
}
debug = require('debug')('web:server')


console.log dim "SpaceTweet web server #{version}\n"

doc = """
Provides Exosphere communication infrastructure services in development mode.

Usage:
  start --html-port=<html-port> --assets-port=<assets-port>
  start -h | --help
  start -v | --version
"""


start-html-server = (done) ->
  server = new HtmlServer
    ..on 'error', (err) -> console.log red err
    ..listen +options['--html-port']
    ..on 'listening', ->
      console.log "#{green 'HTML server'} online at port #{cyan server.port!}"
      done!


start-asset-server = (done) ->
  asset-server = new AssetServer
    ..listen +options['--assets-port'], ->
      console.log "#{green 'asset server'} online at port #{cyan asset-server.port}"
      done!


run = ->
  async.parallel [start-html-server, start-asset-server], (err) ->
    console.log green 'all systems go'



options = docopt doc, help: no
switch
| options['-h'] or options['--help']     =>  console.log doc
| options['-v'] or options['--version']  =>
| otherwise                              =>  run options
