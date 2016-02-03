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

  'users.create': ({name}) ->
    debug "creating user #{name}"
    # db.create ...
    # response.send id: 1, name: name
