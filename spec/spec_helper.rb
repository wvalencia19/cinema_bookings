require 'rack/test'
require 'factory_bot'

ENV['RACK_ENV'] = 'test'

RSpec.configure do |config|
  include Rack::Test::Methods
  config.color = true
  config.formatter = :documentation

  config.mock_with :rspec
  config.expect_with :rspec

  config.raise_errors_for_deprecations!

  config.include FactoryBot::Syntax::Methods
  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.around(:each) do |example|
    DB.transaction(:rollback=>:always, :auto_savepoint=>true){example.run}
  end
end

def app
  Api::Routes
end
