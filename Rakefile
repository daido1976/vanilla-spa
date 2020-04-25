# frozen_string_literal: true

require './pg_client'

dbname = 'sinatra-db'

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

    pg = PgClient.new(dbname: dbname)

    sql = <<~SQL
      CREATE TABLE weather (
      city varchar(80),
      temp_lo int,
      temp_hi int,
      prcp real,
      date date
      );
    SQL

    pg.exec(sql)
  end
end
