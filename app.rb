# encoding: utf-8                                                                

require 'sinatra/base'
require "sinatra/config_file"
require 'slim'
require 'sass'
require 'coffee-script'
require 'active_record'

ActiveRecord::Base.establish_connection(
	adapter: 'sqlite3',
	database: 'dev.db'
)

require_relative 'models/init'

class App < Sinatra::Base
	register Sinatra::ConfigFile
	config_file 'config.yml'

	get '/' do
		slim :index
	end

	get %r{^/css/(.*)\.css$} do
		scss :"scss/#{params[:captures].first}"
	end

	get %r{^/js/(.*)\.js$} do
		coffee :"coffee/#{params[:captures].first}"
	end

end
