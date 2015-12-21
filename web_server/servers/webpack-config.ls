require! {
  'webpack'
  'path'
}


module.exports =

  devtool: 'eval',                                        # Makes sure errors in console map to the correct file and line number


  entry:
    'webpack/hot/dev-server'                                         # For hot style updates
    'webpack-dev-server/client?http://localhost:8080'                # The script refreshing the browser on none hot updates
     path.resolve __dirname, '..', 'app', 'client', 'javascripts', 'main.ls'   # Our application


  output:

    # We need to give Webpack a path. It does not actually need it,
    # because files are kept in memory in webpack-dev-server, but an
    # error will occur if nothing is specified. We use the build path
    # as that points to where the files will eventually be bundled
    # in production
    path: path.resolve(__dirname, '..', 'app', 'build')
    filename: 'bundle.js'

    # Everything related to Webpack should go through a build path,
    # localhost:3000/build. That makes proxying easier to handle
    public-path: '/build/'


  module:

    loaders:

      * test: /\.ls$/
        loader: 'livescript'
        exclude: [ path.resolve __dirname, '..', 'node_modules' ]

      * test: /\.css$/
        loader: 'style!css'


  plugins: [new webpack.HotModuleReplacementPlugin()]
