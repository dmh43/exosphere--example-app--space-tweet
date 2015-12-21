require! {
  'http'
  './app-server'
}
debug = require('debug')('messaging:server')


on-server-error = (error) ->
  | error.syscall isnt 'listen'  =>  throw error

  console.error switch error.code
  | 'EACCES'      =>  'Port requires elevated privileges'
  | 'EADDRINUSE'  =>  'Port is already in use'
  | _             =>  error
  process.exit 1


server = http.create-server app-server
  ..on 'listening', -> debug "web server online at port #{server.address!port}"
  ..on 'error', on-server-error
  ..listen parse-int(process.env.PORT or '3000')
