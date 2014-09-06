gulp = require 'gulp'
preen = require 'preen'

gulp.task 'clean', (cb)->
  preen.preen {}, cb