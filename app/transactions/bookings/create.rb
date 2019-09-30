require_relative '../base_transaction'

module Bookings
  class Create < BaseTransaction
    tee :params

    step :customer_exists?
    step :valid_movie
    step :valid_remaining_quota
    step :create_booking

    def params(input)
      @params = input.fetch(:params)
    end

    def customer_exists?(input)
      exists = Customer.where(id: @params[:customer_id]).count.positive?
      if exists
        Success(input)
      else
        Failure(error: Constants::CUSTOMER_INVALID)
      end
    end

    def valid_movie(input)
      day = Constants::BIT_WISE_DAYS[DaysHelper.name_from_date(@params[:date])]
      exists = Movie.movies_by_id_and_day(@params[:movie_id], day).count.positive?
      if exists
        Success(input)
      else
        Failure(error: Constants::INVALID_MOVIE)
      end
    end

    def valid_remaining_quota(input)
      total_bookings = Booking.where(date: @params[:date]).count
      if total_bookings < Constants::MAX_BOOKING_QUOTA
        Success(input)
      else
        Failure(error: Constants::MAX_BOOKINGS_REACHED)
      end
    end

    def create_booking(input)
      Booking.insert(customer_id: @params[:customer_id],
                     movie_id: @params[:movie_id],
                     date: @params[:date])
      Success(input)
    rescue StandardError
      Failure(error: Constants::ERROR_SAVING_BOOKING)
    end
  end
end
