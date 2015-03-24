g = require 'gulp'
browserSync = require 'browser-sync'
gulpFilter = require 'gulp-filter' #文字列で対象ファイル探す？
mainBowerFiles = require 'main-bower-files'  #bowerのファイル
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'
plumber = require 'gulp-plumber'  #コンパイルエラー時に中断させない
del = require 'del'

# 最初に削除
g.task 'clean' , ->
  del [
	  "public/js/libs/*"
	  "public/css/libs/*"
	  "public/js/*.js"
	  "public/css/*.css"
  ]

# bowerのファイルをpublic配下に
g.task 'bower-files', ->
  jsFilter = gulpFilter('**/*.js')
  cssFilter = gulpFilter('**/*.css')

  g.src mainBowerFiles()
	  .pipe jsFilter
	  .pipe g.dest('public/js/libs/')
	  .pipe jsFilter.restore()
	  .pipe cssFilter
	  .pipe g.dest('public/css/libs/')

# assetsのcoffeeをコンパイルしpublic配下に
g.task 'js', ->
  g.src 'assets/coffee/*.coffee'
	  .pipe plumber()
	  .pipe coffee()
	  .pipe g.dest('public/js')

## assetsのscssをコンパイルしpublic配下に
g.task 'css', ->
  g.src 'assets/sass/*.scss'
	  .pipe plumber()
	  .pipe sass()
	  .pipe g.dest('public/css')

# brwoserSync
g.task 'bs', ->
  browserSync.init(null, {
	  proxy: 'localhost:6000'
  })

g.task 'bsReload', ->
  browserSync.reload()

# Build
g.task 'build'  ,
	[
		'bs'
		'bower-files'
		'js'
		'css'
	]

# Watch
g.task 'default', ['clean','build'], ->
  g.watch 'assets/coffee/*.coffee' ,['js']
  g.watch 'assets/sass/*.scss' ,['css']
  g.watch 'app.rb', ['bsReload']
  g.watch 'views/*.slim', ['bsReload']
