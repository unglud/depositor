mongoose = require 'mongoose'

bankSchema = mongoose.Schema({
  name : String
  deposits : [
    {
      name : String
      min_sum : Number
      capitalization : Boolean
      payments : Number #0 - in the end, 1 - everymonth, 3 - every 3 month
      variants : [
        {
          _id : mongoose.Schema.Types.ObjectId
          rate : Number
          min_term : Number
        }
      ]
    }
  ]
})

bankSchema.static 'getAll', (callback)->
  return this.find {}, callback

module.exports = mongoose.model 'bank', bankSchema