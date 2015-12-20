require! {
  'webpack'
  'webpack-dev-server'
  './webpack.config.ls' : webpack-config
  'path'
  'fs'
}
debug = require('debug')('web:assets')


compiler = webpack webpack-config

compiler.plugin 'compile', ->
  debug 'starting asset compilation'

compiler.plugin 'done', ->
  debug "asset compilation completed"


module.exports = new webpack-dev-server compiler,

  publicPath: '/build/',

  # Configure hot replacement
  hot: true,

  # The rest is terminal configurations
  quiet: false,
  noInfo: true,
  stats:
    colors: true
