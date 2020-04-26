# frozen_string_literal: true

require 'forwardable'
require 'pg'

# PostgreSQL client
class PgClient
  extend Forwardable
  def_delegator :@connection, :exec

  def initialize(dbname:)
    @connection = PG.connect(dbname: dbname)
  end
end
