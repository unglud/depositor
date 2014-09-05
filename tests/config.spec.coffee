describe "Configuration setup", ->
  it "should load local configurations", (next)->
    config = require('../config')('local')
    expect config.mode
    .toBe 'local'
    next()

  it "should load staging configurations", (next)->
    config = require('../config')('staging')
    expect config.mode
    .toBe 'staging'
    next()

  it "should load production configurations", (next)->
    config = require('../config')('production')
    expect config.mode
    .toBe 'production'
    next()