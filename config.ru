# Require config/environment.rb
require ::File.expand_path('../config/environment',  __FILE__)

configure do
  set :root, File.dirname(__FILE__)
  set :public_folder, "public/app"
end

get "/" do
  File.read("public/app/index.html")
end

run Sinatra::Application
