require! {
  'events' : {EventEmitter}
  \express
  'exprestive'
  'http'
  \path
  'rails-delegate' : {delegate, delegate-event}
  # 'serve-favicon'
  \morgan : logger
  'cookie-parser'
  'body-parser'
  './webpack-config'
  'webpack-dev-middleware'
  'webpack'
}


class HtmlServer extends EventEmitter

  ->
    @app = express!

    dev-middleware = webpack-config
    |> webpack
    |> webpack-dev-middleware _, publicPath: '/assets/', noInfo: yes

    # view engine setup
    @app.set 'views', path.join(__dirname, '..', 'app', 'server', 'views')
      ..set 'view engine', \jade

      # ..use(serve-favicon(path.join(__dirname, 'public', 'favicon.ico')))
      ..use logger \dev
      ..use bodyParser.json!
      ..use bodyParser.urlencoded extended: false
      ..use cookieParser!

      ..use dev-middleware
      ..use exprestive app-dir: '../app/server', controllers-pattern: 'controllers/*.ls'

      ..use (req, res, next) ->   # route not found
        err = new Error 'Not Found'
        err.status = 404
        next err

    @server = http.create-server @app

    delegate \listen, from: @, to: @server
    delegate-event \listening \error, from: @server, to: @


  port: ->
    @server.address!port



module.exports = HtmlServer
