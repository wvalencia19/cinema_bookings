# require File.expand_path('config/application', __dir__)
#
# Api::Routes.compile
# run Api::Routes

require 'rack/cors'
require_relative 'config/application'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: %i[get post put patch delete options]
  end
end

run App.new
