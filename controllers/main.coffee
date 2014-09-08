Bank = require('../models/bank')

exports.before = (req, res, next)->

  Bank.getAll (err, banks)->
    if err then throw err
    req.banks = banks
    # cant find that
    if (!req.banks) then return next('route');
    # found it, move on to the routes
    next()

exports.index = (req, res, next)->
  data = {
    locale: req.getLocale()
    banks: req.banks
    getVarCount: (bank) ->
      count = 0
      for deposit in bank.deposits
        count+= deposit.variants.length
      count
    getOveralCount: (banks) ->
      count = 0
      for bank in banks
        count+= this.getVarCount(bank)
      count
    __: (string)->
      res.__ string
  }
  res.render 'main', data
