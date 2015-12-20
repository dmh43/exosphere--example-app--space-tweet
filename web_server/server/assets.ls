require! {
  'webpack'
  'webpack-dev-server'
  './../webpack.config.ls' : webpack-config
  'path'
  'fs'
}


compilation-start-time = null

compiler = webpack webpack-config

compiler.plugin 'compile', ->
  console.log 'bundling...'
  compilation-start-time := Date.now!

compiler.plugin 'done', ->
  console.log "Bundled in #{Date.now! - compilation-start-time}ms!"


module.exports = new webpack-dev-server compiler,

  publicPath: '/build/',

  # Configure hot replacement
  hot: true,

  # The rest is terminal configurations
  quiet: false,
  noInfo: true,
  stats:
    colors: true
