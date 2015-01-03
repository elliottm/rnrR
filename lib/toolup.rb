require 'sinatra/base'
require 'sinatra/partial'
require 'data_mapper'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/sculpt_#{env}")

require './lib/user'

DataMapper.finalize
DataMapper.auto_upgrade!

class Toolup < Sinatra::Base

set :views, File.join(File.dirname(__FILE__), '..', 'views')
set :public_folder, File.join(File.dirname(__FILE__), '..', 'public')
set :partial_template_engine, :erb

  get '/' do
    erb :welcome
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end


