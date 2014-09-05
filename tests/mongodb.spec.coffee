describe "MongoDB", ->

  config = require('../config')(process.env.MODE)

  it "is there a server running", (next)->
    MongoClient = require 'mongodb'
    .MongoClient

    MongoClient.connect 'mongodb://' + config.mongo.host + ':' + config.mongo.port + '/' + config.mongo.db, (err)->
      expect err
      .toBe null
      next()