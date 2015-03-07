# Require config/environment.rb
require ::File.expand_path('../config/environment',  __FILE__)

configure do
  set :root, File.dirname(__FILE__)
  set :public_folder, "public"
end

get "/" do
  File.read("public/index.html")
end

use ActiveRecord::ConnectionAdapters::ConnectionManagement

run Sinatra::Application
