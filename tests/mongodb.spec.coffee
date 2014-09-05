describe "MongoDB", ->

  config = require('../config')(process.env.MODE)

  it "is there a server running", (next)->
    MongoClient = require 'mongodb'
    .MongoClient

    console.log('try to connect to '+ 'mongodb://' + config.mongo.host + ':' + config.mongo.port + '/' + config.mongo.dbname);

    MongoClient.connect 'mongodb://' + config.mongo.host + ':' + config.mongo.port + '/' + config.mongo.dbname, (err)->
      expect err
      .toBe null
      next()