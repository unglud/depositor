config = require('./config')(process.env.MODE)
express = require 'express'
mongo = require 'mongodb'
.MongoClient

app = express()

app.get '/', (req, res) ->
  res.send 'Hello world'


app.use (err, req, res, next)->
  console.error err.stack
  res
    .status 500
    .send 'Something broke!'


mongo.connect 'mongodb://' + config.mongo.host + ':' + config.mongo.port + '/' + config.mongo.dbname, (err, db)->
  if err
    console.log 'Sorry, there is no mongo db server running.'
  else
    attachDB = (req,res, next)->
      req.db = db
      next()

    server = app.listen process.env.PORT || 5000, ->
      console.log 'Listening on port %d', server.address().port;

  return

