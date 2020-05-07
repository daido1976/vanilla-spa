# frozen_string_literal: true

require './pg_client'

# Post model
class Post
  # FIXME: return boolean or id
  # @return [void]
  def self.create(name:, comment:)
    sql = <<~SQL
      INSERT INTO posts (name, comment, created_at) VALUES (\'#{name}\', \'#{comment}\', \'#{Time.now.strftime('%F %T')}\');
    SQL
    pg.exec(sql)
  end

  # @return [Array]
  def self.all
    sql = <<~SQL
      SELECT * FROM posts;
    SQL
    pg.exec(sql).to_a
  end

  def self.pg
    @pg ||= PgClient.new
  end
end
