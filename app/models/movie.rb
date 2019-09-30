class Movie < Sequel::Model
  one_to_many :bookings

  def self.movies_by_day(day)
    Movie.where(Sequel.lit("(days & #{day}) = #{day}")).all
  end

  def self.movies_by_id_and_day(id, day)
    Movie.where(Sequel.lit("id = ? AND (days & #{day}) = #{day}", id)).all
  end
end
