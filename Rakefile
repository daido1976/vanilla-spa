# frozen_string_literal: true

dbname = 'sinatra-db'
define_method(:already_exists?) { `psql -l`.split.include?(dbname) }

namespace :db do
  desc 'Create DB'
  task :create do
    next puts "error: #{dbname} already exists" if already_exists?

    if system("createdb #{dbname}")
      puts "success: #{dbname} created!"
    else
      puts 'error: failed to create'
    end
  end

  desc 'Drop DB'
  task :drop do
    next puts "error: #{dbname} does not exist" unless already_exists?

    if system("dropdb #{dbname}")
      puts "success: #{dbname} dropped!"
    else
      puts 'error: failed to drop'
    end
  end
end
