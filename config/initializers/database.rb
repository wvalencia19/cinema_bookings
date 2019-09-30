require 'yaml'
require 'sequel'

# Init Db
if ENV['RACK_ENV'] == 'production'
  DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://localhost/cinema_booking')
elsif ENV['RACK_ENV'] == 'test'
  DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://localhost/cinema_booking_test')
else
  db_config_file = File.join(File.dirname(__FILE__), '..', 'database.yml')
  if File.exist?(db_config_file)
    config = YAML.safe_load(File.read(db_config_file))
    config['host'] = ENV['POSTGRES_HOST'] unless ENV['POSTGRES_HOST'].nil?
    config['database'] = ENV['POSTGRES_DB'] unless ENV['POSTGRES_DB'].nil?
    config['user'] = ENV['POSTGRES_USER'] unless ENV['POSTGRES_USER'].nil?
    config['password'] = ENV['POSTGRES_PASSWORD'] unless ENV['POSTGRES_PASSWORD'].nil?
    DB = Sequel.connect(config)
  end
end

