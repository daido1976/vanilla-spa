# frozen_string_literal: true

require 'forwardable'
require 'pg'

# PostgreSQL client
class PgClient
  extend Forwardable
  def_delegator :@connection, :exec

  def initialize
    @connection = PG.connect('postgres://postgres:password@localhost:35432/sinatra-db')
  end
end
