require! \http


class HttpListener

  ->
    @calls = []
    @server = null

  close: ->
    @server.close!

  listen: (port, done) ->
    @server = http.createServer @_request-handler
      ..listen port, '127.0.0.1', done
    @

  _request-handler: ({method, url}, res) ~>
    @calls.push {method, url}
    res.end!



module.exports = HttpListener
