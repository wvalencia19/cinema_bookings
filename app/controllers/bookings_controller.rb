class BookingsController
  def create(params)
    Bookings::Create.call(params: params) do |m|
      m.success do
        return Constants::BOOKING_CREATED
      end
      m.failure do |failure|
        raise StandardError, failure[:error]
      end
    end
  end

  def bookings_by_dates_range(params)
    Booking.bookings_by_dates_range(params[:from], params[:to])
  end
end
