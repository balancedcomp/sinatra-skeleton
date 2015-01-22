# encoding: utf-8                                                                

require 'sinatra/base'
require "sinatra/config_file"
require 'slim'
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

end
