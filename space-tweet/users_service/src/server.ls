debug = require('debug')('users')
mongo-client = require('mongodb').MongoClient
N = require 'nitroglycerin'


db = null

module.exports =

  before-all: (done) ->
    mongo-client.connect 'mongodb://localhost:27017/exosphere-sdk-poc-users', N (err, mongo_db) ->
      debug 'MongoDB connected'
      db := mongo_db
      done!


  create: ({name}, response) ->
    debug "creating user #{name}"
    # db.create ...
    response.send id: 1, name: name
