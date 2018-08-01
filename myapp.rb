require 'sinatra'

get '/' do
  erb :index
end

get '/custom.scss' do
  scss :custom
end
