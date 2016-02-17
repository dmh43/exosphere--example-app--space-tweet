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

doc = """
Provides Exosphere communication infrastructure services in development mode.

Usage:
  start --exorelay-port=<exorelay-port> --exocomm-port=<exocomm-port>
  start -h | --help
  start -v | --version
"""
options = docopt doc, help: no


global.config = {}

start-html-server = (done) ->
  html-server = new HtmlServer
    ..on 'error', (err) -> console.log red err
    ..on 'listening', ->
      console.log "#{green 'HTML server'} online at port #{cyan html-server.port!}"
      done!
    ..listen 3000



start-exorelay = (done) ->
  global.exorelay = new ExoRelay exocomm-port: +options['--exocomm-port']
    ..on 'error', (err) -> console.log red err
    ..on 'online', (port) ->
      console.log "#{green 'ExoRelay'} online at port #{cyan port}"
      done!
    ..listen +options['--exorelay-port']


run = ->
  async.parallel [start-html-server,
                  start-exorelay], (err) ->
    console.log green 'all systems go'


switch
| options['-h'] or options['--help']     =>  console.log doc
| options['-v'] or options['--version']  =>
| otherwise                              =>  run options
