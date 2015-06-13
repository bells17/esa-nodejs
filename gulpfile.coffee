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

buildItems = [
  'src/*.coffee'
  'src/**/*.coffee'
]

gulp.task 'build', ->
  gulp
    .src buildItems
    .pipe coffee()
    .pipe gulp.dest('lib/')

gulp.task 'watch', [ 'build' ], ->
  watcher = gulp.watch buildItems, [ 'build' ]
  watcher.on 'change', (event)->
    console.log "File #{event.path} was #{event.type}, running tasks..."

gulp.task 'test', ->
  process.env.PWD = __dirname

  gulp
    .src([
      'test/*.coffee'
      'test/**/*.coffee'
    ], {read: false})
    .pipe(mocha(mochaOptions))

gulp.task 'default', [ 'watch' ]
