require! {
  'events' : {EventEmitter}
  \express
  'http'
  \path
  'rails-delegate' : {delegate, delegate-event}
  # 'serve-favicon'
  \morgan : logger
  'cookie-parser'
  'body-parser'
}


class HtmlServer extends EventEmitter

  ->
    @app = express!

    # view engine setup
    @app.set 'views', path.join(__dirname, '..', 'app', 'server', 'views')
      ..set 'view engine', \jade

      # ..use(serve-favicon(path.join(__dirname, 'public', 'favicon.ico')))
      ..use logger \dev
      ..use bodyParser.json!
      ..use bodyParser.urlencoded extended: false
      ..use cookieParser!
      ..use express.static path.join(__dirname, '..', 'app', 'client')

      ..use '/', require('../app/server/controllers/index')
      ..use '/users', require('../app/server/controllers/users')

      ..use (req, res, next) ->   # route not found
        err = new Error 'Not Found'
        err.status = 404
        next err

    # development error handler, will print stacktrace
    if @app.get('env') is \development
      @app.use (err, req, res, next) ->
        res.status err.status || 500
        res.render 'error', message: err.message, error: err

    # production error handler, no stacktraces leaked to user
    @app.use (err, req, res, next) ->
      res.status err.status || 500
      res.render 'error', message: err.message, error: {}

    @server = http.create-server @app

    delegate \listen, from: @, to: @server
    delegate-event \listening \error, from: @server, to: @


  port: ->
    @server.address!port



module.exports = HtmlServer
