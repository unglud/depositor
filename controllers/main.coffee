Set = require('../models/set')

module.exports.controller = (app) ->

  app.get '/', (req, res) ->
    res.render 'main'

  app.get '/template', (req, res) ->
    res.render 'template'