require! {
  'webpack'
  'webpack-dev-server'
}
debug = require('debug')('web:assets')

compiler = webpack require('./webpack_config.ls')
  ..plugin 'compile', -> debug 'starting asset compilation'
  ..plugin 'done', -> debug "asset compilation completed"


module.exports = new webpack-dev-server compiler,
  public-path: '/build/',
  hot: true,
  quiet: false,
  no-info: true,
  stats:
    colors: true
