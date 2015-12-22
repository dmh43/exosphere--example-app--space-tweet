require! {
  'webpack'
  './webpack-config'
  'webpack-dev-server'
}
debug = require('debug')('web:assets')

compiler = webpack webpack-config
  ..plugin 'compile', -> debug 'starting asset compilation'
  ..plugin 'done', -> debug "asset compilation completed"


module.exports = new webpack-dev-server compiler,
  public-path: '/build/',
  hot: true,
  quiet: false,
  no-info: true,
  stats:
    colors: true
