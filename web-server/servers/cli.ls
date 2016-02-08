# This is the main server file.
#
# It parses the command line and instantiates the two servers for this app:
# * app_server: HTML server
# * asset_server: serves assets
require! {
  'async'
  'chalk' : {dim, red}
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
  #{name} [--html-port=<html-port>] [--assets-port=<assets-port>]
  #{name} -h | --help
  #{name} -v | --version
"""


start-html-server = (done) ->
  server = new HtmlServer
    ..on 'error', (err) -> console.log red err
    ..listen +(options['--html-port'] or 3000)
    ..on 'listening', ->
      debug "html server online at port #{server.port!}"
      done!


start-asset-server = (done) ->
  asset-server = new AssetServer
    ..listen (options['--asset-port'] or 3001), ->
      debug "asset server online at port #{asset-server.port}"
      done!


run = ->
  async.parallel [start-html-server, start-asset-server], (err) ->
    console.log 'ready'



options = docopt doc, help: no
switch
| options['-h'] or options['--help']     =>  console.log doc
| options['-v'] or options['--version']  =>
| otherwise                              =>  run options
