class DaysHelper
  def self.bit_wise_days_from_day(days_param)
    bit_days = 0
    days_param.each do |day|
      bit_days += Constants::BIT_WISE_DAYS[day]
    end
    bit_days
  end

  def self.name_from_date(date)
    date.strftime('%A').downcase
  end
end
