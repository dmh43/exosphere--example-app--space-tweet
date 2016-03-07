require! {
  'merge'
}


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
      res.render 'users/show', {user}


  edit: (req, res) ->
    @send 'user.get-details', id: req.params.id, (user) ->
      res.render 'users/edit', {user}


  update: (req, res) ->
    data = merge true, req.params, req.body
    console.log 11111111111
    console.log data
    @send 'user.update', data, ->
      res.redirect '/users'


module.exports = UsersController
