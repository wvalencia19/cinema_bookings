require 'rake'
require 'sequel'

task :environment do
  ENV['RACK_ENV'] ||= 'development'
end

desc 'API Routes'
task :routes do
  require File.expand_path('config/application', __dir__)
  Api::Routes.routes.each do |api|
    method = api.request_method.ljust(10)
    path = api.path
    puts "#{method} #{path}"
  end
end

namespace :db do
  Sequel.extension(:migration)

  task connect: :environment do
    require './config/initializers/database'
  end

  desc 'Prints current schema version'
  task version: :connect do
    version = DB.tables.include?(:schema_info) ? DB[:schema_info].first[:version] : 0

    $stdout.print 'Schema Version: '
    $stdout.puts version
  end

  desc 'Run all migrations'
  task migrate: :connect do
    Sequel::Migrator.apply(DB, 'db/migrations')
    Rake::Task['db:version'].execute
  end

  desc 'Populate DB tables'
  task seed: :connect do
    require File.expand_path('config/application', __dir__)
    require 'sequel/extensions/seed'
    Sequel.extension :seed
    Sequel::Seeder.apply(DB, 'db/seeds')
  end

  desc 'Perform migration reset'
  task reset: :connect do
    Sequel::Migrator.run(DB, 'db/migrations', target: 0)
    Sequel::Migrator.run(DB, 'db/migrations')
    Rake::Task['db:version'].execute
  end
end

namespace :db_test do
  task :config do
    ENV['RACK_ENV'] = 'test'
    require './config/initializers/database'
    Sequel::Migrator.apply(DB, 'db/migrations')
    Rake::Task['db:version'].execute
  end
end
