class Booking < Sequel::Model
  many_to_one :customer
  many_to_one :movie

  def self.bookings_by_dates_range(from, to)
    Booking.where(date: from..to).all
  end
end
