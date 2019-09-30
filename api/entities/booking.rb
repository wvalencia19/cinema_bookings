module Api
  module Entities
    class Booking < Grape::Entity
    expose :id, as: :booking_id,
           documentation: {
               type: Integer,
               desc: 'booking id'
           }
    expose :movie, using: Entities::Movie,
           documentation: {
               type: Movie,
               desc: 'movie booked'
           }

    expose :customer, using: Entities::Customer,
           documentation: {
               type: Integer,
               desc: 'customer who did the booking'
           }

    expose :date, as: :booking_date,
           documentation: {
               type: Date,
               desc: 'booking date'
           }
    end
  end
end
