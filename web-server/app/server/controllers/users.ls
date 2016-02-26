class UsersController

  ({@send}) ->


  index: (req, res) ->
    @send 'users.list', null, (users) ->
      res.render 'users/index', {users}


  new: (req, res) ->
    res.render 'users/new'


  create: (req, res) ->
    @send 'users.create', req.body, ->
      res.redirect '/users'



module.exports = UsersController
