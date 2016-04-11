require! {
  '../middleware/ensure-authenticated'
  'bluebird': Promise
  'exprestive': {BaseController}
}


class SessionsController extends BaseController

  ({@send}) ->
    @useMiddleware ensure-authenticated, only: \destroy


  index: (req, res) ->
    res.render 'login'


  create: (req, res, next) ->
    @_authenticate-user req.body
      .then (username) ~> @_create-user-session {username}
      .catch next
      .then (sessionId) ->
        res.cookie 'sessionId', sessionId
        res.redirect '/'


  destroy: (req, res, next) ->
    @send 'session.destroy', session-id: req.session-id, (__, {outcome}) ->
      | outcome isnt 'session.destroyed'  =>  return next Error 'unhandled error'
      res.redirect '/'


  _authenticate-user: ({username, password}) -> new Promise (resolve, reject) ~>
    @send 'password-auth.authenticate', {username, password}, (__, {outcome}) ->
      switch outcome
        | 'password-auth.valid-credentials'    =>  resolve username
        | 'password-auth.invalid-credentials'  =>  reject Error 'invalid credentials'
        | _                                    =>  reject Error 'unhandled error'


  _create-user-session: (session-data) -> new Promise (resolve, reject) ~>
    @send 'session.create', session-data, ({sessionId}, {outcome}) ~>
      | outcome isnt 'session.created'  =>  return reject Error 'unhandled error'
      resolve sessionId


module.exports = SessionsController
