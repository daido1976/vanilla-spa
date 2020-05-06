# frozen_string_literal: true

require 'json'
require 'sinatra'
require 'sinatra/reloader' if development?
require './pg_client'

enable :sessions

get '/' do
  send_file "#{Sinatra::Application.public_dir}/index.html"
end

get '/login/:user_id' do
  puts "session[:user_id] => #{session[:user_id]}"
  session[:user_id] = params['user_id']
end

post '/api/posts' do
  json = JSON.parse(request.body.read, symbolize_names: true)

  posts_create_sql = <<~SQL
    INSERT INTO posts (name, comment, created_at) VALUES ('daido', \'#{json[:comment]}\', \'#{Time.now.strftime('%F %T')}\');
  SQL
  pg = PgClient.new
  pg.exec(posts_create_sql)

  posts_all_sql = <<~SQL
    SELECT * FROM posts;
  SQL
  posts = pg.exec(posts_all_sql).to_a

  posts.to_json
end
