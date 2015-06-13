gulp = require 'gulp'
coffee = require 'gulp-coffee'
mocha = require 'gulp-mocha'

mochaOptions =
  compilers: 'coffee:coffee-script/register'
  require: [
    'should'
    'coffee-script'
    'coffee-errors'
  ]
  reporter: 'spec'
  colors: true
  timeout: 10000

gulp.task 'build', ->
  gulp
    .src [
      'src/*.coffee'
      'src/**/*.coffee'
    ]
    .pipe coffee()
    .pipe gulp.dest('lib/')

gulp.task 'test', ->
  process.env.PWD = __dirname

  gulp
    .src([
      'test/*.coffee'
      'test/**/*.coffee'
    ], {read: false})
    .pipe(mocha(mochaOptions))


gulp.task 'default', [ 'build' ]


