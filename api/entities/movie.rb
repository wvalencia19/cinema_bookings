module Api
  module Entities
    class Movie < Grape::Entity
      expose :name,
             documentation: {
                 type: String,
                 desc: 'movie name'
             }
      expose :description,
             documentation: {
                 type: String,
                 desc: 'movie description'
             }
      expose :url,
             documentation: {
                 type: String,
                 desc: 'movie URL with more information about the movie'
             }
    end
  end
end
