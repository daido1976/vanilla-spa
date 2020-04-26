# frozen_string_literal: true

require 'json'
require 'sinatra'

get '/' do
  send_file 'index.html'
end

post '/api/posts' do
  json = JSON.parse(request.body.read, symbolize_names: true)
  posts = [
    {
      comment: json[:comment],
      created_at: Time.now.strftime('%F at %I:%M%#p')
    }
  ]
  posts.to_json
end
