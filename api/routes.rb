module Api
  class Routes < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api

    mount Endpoints::Movies
    mount Endpoints::Bookings

    add_swagger_documentation format: :json,
                              info: {
                                  title: 'Cinema Booking'
                              },
                              mount_path: '/oapi',
                              models: [
                                  Entities::ApiError
                              ]
  end
end
