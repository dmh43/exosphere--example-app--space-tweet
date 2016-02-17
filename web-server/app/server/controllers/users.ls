class UsersController

  index: (req, res, next) ->
    global.exorelay.send 'users.list', null, (users) ->
      res.render 'users/index', {users}

  new: (req, res, next) ->
    res.render 'users/new'

  create: (req, res, next) ->
    global.exorelay.send 'users.create', req.body, ->
      res.redirect '/users'



module.exports = UsersController
