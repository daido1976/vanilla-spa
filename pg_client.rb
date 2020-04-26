# frozen_string_literal: true

require 'forwardable'
require 'pg'

# PostgreSQL client
class PgClient
  extend Forwardable
  def_delegator :@connection, :exec

  def initialize
    @connection = PG.connect(dbname: 'sinatra-db')
  end
end
