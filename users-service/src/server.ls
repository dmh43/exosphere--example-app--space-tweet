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
    debug "creating user #{name}"
    # db.create ...
    reply 'users.created', id: 1, name: name
