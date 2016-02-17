class UsersController

  index: (req, res) ->
    global.exorelay.send 'users.list', null, (users) ->
      res.render 'users/index', {users}

  new: (req, res) ->
    res.render 'users/new'

  create: (req, res) ->
    global.exorelay.send 'users.create', req.body, ->
      res.redirect '/users'



module.exports = UsersController
