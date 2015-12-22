debug = require('debug')('users')
require! '../../exosphere-service-node'
mongo-client = require('mongodb').MongoClient
N = require 'nitroglycerin'


port = parse-int process.env.PORT || throw 'No port provided'
exosphere-service-node.listen port: port, setup: (done) ->
  mongo-client.connect 'mongodb://localhost:27017/exosphere-sdk-poc-users', (err, db) ->
    debug 'MongoDB connected'
    done null, {db}

