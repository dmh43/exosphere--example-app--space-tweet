require! {
  'events' : {EventEmitter}
  'express'
  'exprestive'
  'jade'
  'http'
  'path'
  'rails-delegate' : {delegate, delegate-event}
  'serve-favicon'
  'morgan' : logger
  'cookie-parser'
  'body-parser'
}


class HtmlServer extends EventEmitter

  ->
    @app = express!

    # view engine setup
    @app.set 'views', path.join(__dirname, '..', 'app', 'server', 'views')
      ..set 'view engine', \jade

      ..use serve-favicon path.join(__dirname, '..', 'app', 'server', 'public', 'favicon.ico')
      ..use logger \dev
      ..use bodyParser.json!
      ..use bodyParser.urlencoded extended: false
      ..use cookieParser!
      ..use express.static path.join(__dirname, '..', 'app', 'client')

      ..use exprestive do
        app-dir: '../app/server'
        controllers-pattern: 'controllers/*.ls'
        dependencies: global.exorelay

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
