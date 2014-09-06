Set = require('../models/set')

module.exports.controller = (app) ->

  app.get '/', (req, res) ->
    req.locale
    res.render 'main',{
      locale: req.getLocale()
      __: (string)->
        res.__ string
    }

  app.get '/template', (req, res) ->
    res.render 'template'