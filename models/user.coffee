mongoose = require 'mongoose'
module.exports = mongoose.model('user', {
  link: String
})