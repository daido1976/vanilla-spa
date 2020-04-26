# frozen_string_literal: true

require 'json'
require 'sinatra'
require './pg_client'

get '/' do
  send_file 'index.html'
end

post '/api/posts' do
  json = JSON.parse(request.body.read, symbolize_names: true)
  sql = <<~SQL
    INSERT INTO posts (name, comment, created_at) VALUES ('daido', \'#{json[:comment]}\', \'#{Time.now.strftime('%F %T')}\');
  SQL

  pg = PgClient.new
  pg.exec(sql)
  sql = <<~SQL
    SELECT * FROM posts;
  SQL
  posts = pg.exec(sql).to_a
  posts.to_json
end
