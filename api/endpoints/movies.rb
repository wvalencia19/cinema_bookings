module Api
  module Endpoints
    class Movies < Grape::API
      namespace :movies do
        desc 'Get movie.',
             summary: 'Movies by day',
             detail: 'Returns movies that are being shown given one week day.',
             is_array: true,
             success: Entities::Movie
        params do
          requires :day, type: String, values: Constants::DAYS
        end
        get ':day' do
          movies = MoviesController.new.movies_by_day(params[:day])
          present :movies, movies, with: Entities::Movie
        end

        desc 'Create a Movie',
             summary: 'Create a movie',
             detail: 'Allows to create movies in the system and associate them to the days a week in which they are being shown'
        params do
          requires :name, type: String
          optional :description, type: String
          optional :url, type: String
          requires :days, type: Array[String], values: Constants::DAYS
        end
        post do
          begin
            MoviesController.new.create(declared(params))
          rescue StandardError => e
            status 400
            e
          end
        end
      end
    end
  end
end