require! \http


class HttpListener

  ->
    @calls = []

  listen: (port, done) ->
    http.createServer @_request-handler
        .listen port, '127.0.0.1', done
    @

  _request-handler: ({method, url}, res) ~>
    @calls.push {method, url}
    res.end!



module.exports = HttpListener
