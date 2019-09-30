require_relative 'environment'
require_relative 'boot'

require 'routes'

class DocApp
  def call(env)
    @env = env
    [200, { 'Content-Type' => 'text/html' }, [template]]
  end

  def template
    prefix = Api::Routes.prefix ? "/#{Api::Routes.prefix}" : ''
    "<!DOCTYPE html>
    <html>
      <head>
        <title>ReDoc API documentation</title>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <link href='https://fonts.googleapis.com/css?family=Montserrat:300,400,700|Roboto:300,400,700' rel='stylesheet'>
        <style>
          body {
            margin: 0;
            padding: 0;}
        </style>
      </head>
      <body>
        <redoc spec-url='http://#{server}:#{port}#{prefix}/#{Api::Routes.version}/oapi.json'></redoc>
        <script src='https://rebilly.github.io/ReDoc/releases/latest/redoc.min.js'> </script>
      </body>
    </html>"
  end

  def server
    @env['SERVER_NAME']
  end

  def port
    @env['SERVER_PORT']
  end
end

class App
  def initialize
    @apps = {}
  end

  def call(env)
    if Api::Routes.recognize_path(env['REQUEST_PATH'])
      Api::Routes.call(env)
    elsif env['REQUEST_PATH'] == '/doc'
      DocApp.new.call(env)
    else
      [403, { 'Content-Type': 'text/plain' }, ['403 Forbidden']]
    end
  end
end
