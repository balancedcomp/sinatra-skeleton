g = require 'gulp'
#browserSync = require 'browser-sync'
gulpFilter = require 'gulp-filter' #文字列で対象ファイル探す？
mainBowerFiles = require 'main-bower-files'  #bowerのファイル
sass = require 'gulp-sass'
coffee = require 'gulp-coffee'
plumber = require 'gulp-plumber'  #コンパイルエラー時に中断させない
del = require 'del'

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

## assetsのscssをコンパイルしpublic配下に
g.task 'css', ->
  g.src 'assets/sass/*.scss'
	  .pipe plumber()
	  .pipe sass()
	  .pipe g.dest('public/css')

# assetsのcoffeeをコンパイルしpublic配下に
g.task 'js', ->
  g.src 'assets/coffee/*.coffee'
	  .pipe plumber()
	  .pipe coffee()
	  .pipe g.dest('public/js')

# brwoserSync
#g.task 'bs', ->
#  browserSync.init(null, {
#	  proxy: 'localhost:6000'
#  })

#g.task 'bsReload', ->
#  browserSync.reload()

# 削除
g.task 'clean' , ->
  del [
	  "public/js/libs/*"
	  "public/css/libs/*"
	  "public/js/*.js"
	  "public/css/*.css"
  ]

# Build
g.task 'build'  ,
	[
#		'bs'
		'bower-files'
		'js'
		'css'
	]

# Watch
g.task 'default', ['clean','build'], ->
  g.watch 'assets/coffee/*.coffee' ,['js']
  g.watch 'assets/sass/*.scss' ,['css']
#  g.watch 'app.rb', ['bsReload']
#  g.watch 'views/*.slim', ['bsReload']
