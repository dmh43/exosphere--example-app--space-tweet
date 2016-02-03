require! {
  'mongodb' : {MongoClient}
  'nitroglycerin' : N
}
debug = require('debug')('users-service')


module.exports =

  before-all: (done) ->
    MongoClient.connect 'mongodb://localhost:27017/space-tweet-users', N (mongo-db) ->
      @db = mongo-db
      @collection = db.collection 'users'
      debug 'MongoDB connected'
      done!


  'users.create': ({name}, {reply}) ->
    | not name  =>  return reply 'users.not-created', error: 'Name cannot be blank'
    debug "creating user #{name}"
    # db.create ...
    reply 'users.created', id: 1, name: name


  'users.list': (_, {reply}) ->
    collection.find({}).to-array N (users) ->
      reply 'users.listed', count: users.length, users: users
