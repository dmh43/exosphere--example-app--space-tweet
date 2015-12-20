require! {
  \express
  \path
  # 'serve-favicon'
  \morgan : logger
  'cookie-parser'
  'body-parser'
  '../routes/index'
  '../routes/users'
}


app = express!

# view engine setup
app.set 'views', path.join(__dirname, '..', 'views')
  ..set 'view engine', \jade

  # ..use(serve-favicon(path.join(__dirname, 'public', 'favicon.ico')))
  ..use logger \dev
  ..use bodyParser.json!
  ..use bodyParser.urlencoded extended: false
  ..use cookieParser!
  ..use express.static path.join(__dirname, '..', 'app')

  ..use '/', index
  ..use '/users', users

  ..use (req, res, next) ->   # route not found
    err = new Error 'Not Found'
    err.status = 404
    next err


# ERROR HANDLERS

# development error handler
# will print stacktrace
if app.get('env') is \development
  app.use (err, req, res, next) ->
    res.status err.status || 500
    res.render 'error',
      message: err.message,
      error: err

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status err.status || 500
  res.render 'error',
    message: err.message,
    error: {}


module.exports = app
