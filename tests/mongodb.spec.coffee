describe "MongoDB", ->

  config = require('../config')(process.env.MODE)

  it 'try to connect to '+ 'mongodb://' + config.mongo.host + ':' + config.mongo.port + '/' + config.mongo.dbname

  xit "is there a server running", (next)->
    MongoClient = require 'mongodb'
    .MongoClient

    MongoClient.connect 'mongodb://' + config.mongo.host + ':' + config.mongo.port + '/' + config.mongo.dbname, (err, db)->
      expect err
      .toBe null
      expect db
      .toBeDefined();
      next()
