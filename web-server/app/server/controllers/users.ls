class UsersController

  ({@send}) ->


  index: (req, res) ->
    @send 'users.list', null, (users) ->
      res.render 'users/index', users


  new: (req, res) ->
    res.render 'users/new'


  create: (req, res) ->
    @send 'users.create', req.body, ->
      res.redirect '/users'

  show: (req, res) ->
    @send 'user.get-details', id: req.params.id, (user) ->
      console.log user
      res.render 'users/show', {user}


module.exports = UsersController
