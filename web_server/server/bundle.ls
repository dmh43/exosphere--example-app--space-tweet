require! {
  'webpack'
  'webpack-dev-server'
  './../webpack.config.ls' : webpack-config
  'path'
  'fs'
}


compilation-start-time = null

module.exports = ->

  compiler = webpack webpack-config

  compiler.plugin 'compile', ->
    console.log 'bundling...'
    compilation-start-time := Date.now!

  compiler.plugin 'done', ->
    console.log "Bundled in #{Date.now! - compilation-start-time}ms!"

  bundler = new webpack-dev-server compiler,

    publicPath: '/build/',

    # Configure hot replacement
    hot: true,

    # The rest is terminal configurations
    quiet: false,
    noInfo: true,
    stats:
      colors: true

  # We fire up the development server and give notice in the terminal
  bundler.listen 8080, 'localhost', ->
    console.log 'Starting asset server...'
