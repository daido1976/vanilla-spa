# frozen_string_literal: true

require 'json'
require 'minitest/autorun'
require 'rack/test'
require './myapp'

# test myapp.rb
class MyAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_get_root
    get '/'
    assert_equal 200, last_response.status
    assert_includes last_response.body, 'Hello!'
  end

  def test_get_login
    get '/login/test_user'
    assert_equal 200, last_response.status
    assert_equal 'test_user', last_request.session['user_id']
  end

  def test_post_api_posts
    post '/api/posts', JSON.generate(comment: 'test!')
    assert_equal 200, last_response.status
    assert_equal 'test!', JSON.parse(last_response.body, symbolize_names: true).last[:comment]
  end
end
