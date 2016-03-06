require! {
  'events' : {EventEmitter}
  'rails-delegate' : {delegate}
  'webpack'
  './webpack-config'
  'webpack-dev-server'
}
debug = require('debug')('web:assets')


class AssetServer extends EventEmitter

  (@port) ->

    webpack-config.entry[1] = webpack-config.entry[1].replace '{{asset-port}}', @port
    @compiler = webpack webpack-config
      ..plugin 'compile', -> console.log 'starting asset compilation'
      ..plugin 'done', -> console.log "asset compilation completed"

    @server = new webpack-dev-server @compiler,
      public-path: '/build/',
      hot: true,
      quiet: false,
      no-info: true,
      stats:
        colors: true


  listen: (done) ->
    @server.listen @port, 'localhost', done



module.exports = AssetServer
