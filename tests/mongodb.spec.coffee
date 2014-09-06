config = require('../config')(process.env.MODE)
mongoose = require('mongoose')


describe "MongoDB", ->

  xit 'try to connect to '+ 'mongodb://' + config.mongo.host + ':' + config.mongo.port + '/' + config.mongo.dbname

  xit "is there a server running", (next)->

    mongoose.connect 'mongodb://' + config.mongo.host + ':' + config.mongo.port + '/' + config.mongo.dbname, {}, (err) ->
      expect err
      .toBe undefined
      next()
