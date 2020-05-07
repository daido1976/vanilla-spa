# frozen_string_literal: true

require 'minitest/autorun'
require 'rack/test'
require './myapp'

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
end
