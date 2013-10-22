require 'sinatra'

configure do
  set :bind, "0.0.0.0"
end

require "sinatra/reloader"

get '/' do
  puts params.inspect
  "Team Awesome"
end

get '/hello' do
  "hello"
end
