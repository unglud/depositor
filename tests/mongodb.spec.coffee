config = require('../config')(process.env.MODE)
mongoose = require('mongoose')


describe "MongoDB", ->

  it 'try to connect to '+ config.mongo

  it "is there a server running", (next)->

    mongoose.connect config.mongo, {}, (err) ->
      expect err
      .toBe undefined
      mongoose.connection.close()
      next()
