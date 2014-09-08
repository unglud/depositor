config = require('../config')(process.env.MODE)
mongoose = require 'mongoose'
#mongoose.set('debug', true);
#mongoose.connect(config.mongo);
User = require '../models/user'
Bank = require '../models/bank'

User.remove().exec()
.then( ->
  Bank.remove().exec()
  return User.create(require('./users.json'))
)
.then( ->
    return Bank.create(require('./banks.json'))
  )
.then ->
  console.log 'Seeding complete'
  #mongoose.connection.close()
  return
,(err) ->
  console.error err
  #mongoose.connection.close()
  return;