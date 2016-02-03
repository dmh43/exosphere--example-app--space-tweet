require! {
  'mongodb' : {MongoClient}
  'nitroglycerin' : N
}
debug = require('debug')('users')


db = null
MongoClient.connect 'mongodb://localhost:27017/exosphere-sdk-poc-users', N (mongo-db) ->
  db := mongo-db
  debug 'MongoDB connected'


module.exports =

  'users.create': ({name}, {reply}) ->
    | not name  =>  return reply 'users.not-created', error: 'Name cannot be blank'
    debug "creating user #{name}"
    # db.create ...
    reply 'users.created', id: 1, name: name


  'users.list': (_, {reply}) ->
    reply 'users.listed', count: 0, users: []
