config = require('../config')(process.env.MODE)
mongoose = require 'mongoose'
mongoose.set('debug', true);
mongoose.connect('mongodb://' + config.mongo.host + ':' + config.mongo.port + '/' + config.mongo.dbname);
User = require '../models/user'
Bank = require '../models/bank'

User.remove().exec()
.then( ->
  Bank.remove().exec()
  console.log 'removed'
  return User.create(require('./users.json'))
)
.then( ->
    return Bank.create(require('./banks.json'))
  )
.then ->
  console.log 'Done'
  mongoose.connection.close()
  return
,(err) ->
  console.error err
  mongoose.connection.close()
  return;