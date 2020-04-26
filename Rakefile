# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require './pg_client'

dbname = 'sinatra-db'
pg = PgClient.new(dbname: dbname)

# @todo Fix logic
# @return [boolean]
define_method(:already_exists?) { `psql -l`.split.include?(dbname) }

# @return [void]
create_db_service = lambda do
  if system("createdb #{dbname}")
    puts "#{dbname} created"
  else
    puts 'error: failed to create'
  end
end

# @return [void]
drop_db_service = lambda do
  if system("dropdb #{dbname}")
    puts "#{dbname} dropped"
  else
    puts 'error: failed to drop'
  end
end

namespace :db do
  desc 'Create DB'
  task :create do
    next puts "error: #{dbname} already exists" if already_exists?

    create_db_service.call
  end

  desc 'Drop DB'
  task :drop do
    next puts "error: #{dbname} does not exist" unless already_exists?

    drop_db_service.call
  end

  desc 'Reset DB'
  task :reset do
    drop_db_service.call if already_exists?
    create_db_service.call
  end

  desc 'Migrate DB'
  task :migrate do
    next puts "error: #{dbname} does not exist" unless already_exists?

    sql = <<~SQL
      CREATE TABLE posts (
      id serial,
      name varchar(12),
      comment varchar(30),
      created_at timestamp
      );
    SQL

    pg.exec(sql)
  end

  desc 'Add seed to DB'
  task :seed do
    next puts "error: #{dbname} does not exist" unless already_exists?

    sql = <<~SQL
      INSERT INTO posts (name, comment, created_at) VALUES ('daido', 'Cheese!!!', \'#{Time.now.strftime('%F %T')}\');
    SQL

    pg.exec(sql)
  end
end

# rubocop:enable Metrics/BlockLength
