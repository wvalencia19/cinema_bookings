module Api
  module Endpoints
    class Bookings < Grape::API
      namespace :bookings do
        desc 'Bookings by date range',
             summary: 'Bookings by date range',
             detail: 'Returns a list of bookings, given a date range.',
             is_array: true,
             success: Entities::Booking
        params do
          requires :from, type: Date
          requires :to, type: Date
        end
        get do
          booking_controller = BookingsController.new
          bookings = booking_controller.bookings_by_dates_range(declared(params))
          present :bookings, bookings, with: Entities::Booking
        end

        desc 'Create a Booking',
             summary: 'Create a Booking',
             detail: 'Create a reservation for a movie'
        params do
          requires :movie_id, type: Integer
          requires :customer_id, type: Integer
          requires :date, type: Date
        end
        post do
          begin
            BookingsController.new.create(declared(params))
          rescue StandardError => e
            status 400
            e
          end
        end
      end
    end
  end
end
