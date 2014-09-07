mongoose = require 'mongoose'

bankSchema = mongoose.Schema({
  name: String
  deposits: [
    {
      _id: mongoose.Schema.Types.ObjectId
      name: String
      rate: Number
      min_term: Number
      min_sum: Number
      capitalization: Boolean
      payments: Number #0 - in the end, 1 - everymonth, 3 - every 3 month
    }
  ]
})

module.exports = mongoose.model 'bank', bankSchema