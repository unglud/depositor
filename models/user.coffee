mongoose = require 'mongoose'

userSchema = mongoose.Schema({
  id: String
  deposits:[
    {
      deposit_id: mongoose.Schema.Types.ObjectId
      term: Number
      sum: Number
    }
  ]
})

module.exports = mongoose.model('user', userSchema)