# frozen_string_literal: true

dbname = 'sinatra-db'
define_method(:already_exists?) { `psql -l`.split.include?(dbname) }
define_method(:create_db) do
  if system("createdb #{dbname}")
    puts "#{dbname} created"
  else
    puts 'error: failed to create'
  end
end
define_method(:drop_db) do
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

    create_db
  end

  desc 'Drop DB'
  task :drop do
    next puts "error: #{dbname} does not exist" unless already_exists?

    drop_db
  end

  desc 'Reset DB'
  task :reset do
    if already_exists?
      drop_db
      create_db
    else
      create_db
    end
  end
end
