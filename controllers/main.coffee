###var mongoose = require('mongoose')
var Video = require('../models/user');###
module.exports.controller = (app) ->

  app.get '/', (req, res) ->
    res.render('main')