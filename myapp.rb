# frozen_string_literal: true

require 'json'
require 'rack/cors'
require 'sinatra'
require 'sinatra/reloader' if development?
require './post'

enable :sessions

use Rack::Cors do
  allow do
    origins 'http://localhost:4567'
    resource '*', headers: :any, methods: :any, credentials: true
  end
end

get '/' do
  send_file "#{Sinatra::Application.public_dir}/index.html"
end

get '/login/:user_id' do
  puts "session[:user_id] => #{session[:user_id]}"
  session[:user_id] = params['user_id']
end

post '/api/posts' do
  request_body = JSON.parse(request.body.read, symbolize_names: true)

  Post.create(name: 'daido', comment: request_body[:comment])
  posts = Post.all

  posts.to_json
end
