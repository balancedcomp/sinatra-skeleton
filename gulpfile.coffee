g = require('gulp')
$ = require('gulp-load-plugins')()
mainBowerFiles = require('main-bower-files')
browserSync = require('browser-sync')

g.task 'bower-files', ->
  mainBowerFiles().pipe(g.dest('./lib'))

g.task 'bs', ->
  browserSync.init(null, {
	  proxy: 'hostname:9393'
  })

# Tasks
g.task 'bsReload', ->
  browserSync.reload()

# Watch
g.task 'default', ['bs'], ->
  g.watch 'app.rb', ['bsReload']
  g.watch 'views/*.slim', ['bsReload']
  g.watch 'views/scss/*.scss', ['bsReload']
