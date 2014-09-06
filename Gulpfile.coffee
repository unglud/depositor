gulp = require 'gulp'
preen = require 'preen'
concat = require 'gulp-concat'
less = require 'gulp-less'
minifyCSS = require 'gulp-minify-css'

gulp.task 'clean', (cb)->
  preen.preen {}, cb

gulp.task 'css', ->
  gulp.src [
    './bower_components/bootstrap/less/bootstrap.less'
    './src/less/variables.less'
    './src/less/bootswatch.less'
  ]
  .pipe(concat('style.less'))
  .pipe(less())
  .pipe(minifyCSS())
  .pipe(gulp.dest('./public/css/'))

gulp.task 'default', ['clean', 'css'], ()->
  return
