module Constants
  DAYS = %w[monday tuesday wednesday thursday friday saturday sunday].freeze

  BIT_WISE_DAYS = {
      DAYS[0] => 1,
      DAYS[1] => 2,
      DAYS[2] => 4,
      DAYS[3] => 8,
      DAYS[4] => 16,
      DAYS[5] => 32,
      DAYS[6] => 64
  }.freeze

  MAX_BOOKING_QUOTA = 10
  CUSTOMER_INVALID = 'Invalid customer'.freeze
  INVALID_MOVIE = 'The movie does not exist or is not shown on the day entered'.freeze
  MAX_BOOKINGS_REACHED = 'Maximum of bookings reached'.freeze
  ERROR_SAVING_BOOKING = 'Error saving booking in the DB'.freeze
  ERROR_SAVING_MOVIE = 'Error saving movie in the DB'.freeze
  BOOKING_CREATED = 'Booking created'.freeze
end

