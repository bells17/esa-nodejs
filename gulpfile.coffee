gulp = require 'gulp'
coffee = require 'gulp-coffee'

gulp.task 'build', ->
  gulp.src [
    'src/*.coffee'
    'src/**/*.coffee'
  ]
    .pipe coffee()
    .pipe gulp.dest('lib/')

gulp.task 'default', [ 'build' ]
