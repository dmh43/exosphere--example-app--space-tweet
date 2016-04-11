# Add this middleware to routes where you want to ensure a user is authenticated
# Sets req.user to current user's session data
module.exports = (req, res, next) ->
  | not (session-id = req.cookies.session-id)?  =>  return res.redirect @routes.login!

  global.exorelay.send 'session.read', {session-id}, (session-data, {outcome}) ~>
    | outcome isnt 'session.found'  =>  return res.redirect @routes.login!
    res.locals.user = req.user = session-data
    res.locals.session-id = req.session-id = session-id
    next()
