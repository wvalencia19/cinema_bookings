class MoviesController
  def create(params)
    Movie.insert(name: params[:name],
                 description: params[:description],
                 url: params[:url],
                 days: DaysHelper.bit_wise_days_from_day(params[:days]))
    'Movie created'
  rescue StandardError
    Failure(error: Constants::ERROR_SAVING_MOVIE)
  end

  def movies_by_day(day)
    Movie.movies_by_day(Constants::BIT_WISE_DAYS[day])
  end
end
