require 'spec_helper'
require_relative '../../config/application'

describe Api::Routes do
  context 'GET /api/v1/movies/:day' do
    let(:endpoint) { '/api/v1/movies/' }
    let(:response_body) { last_response.body }

    context 'when there is not movie for a day' do
      let(:day) { 'saturday' }
      it 'returns an empty array of statuses' do
        create(:movie)
        get endpoint + day
        expect(last_response.status).to eq(200)
        expect(JSON.parse(response_body)['movies']).to eq []
      end
    end

    context 'when there is  movie for a day' do
      let(:day) { 'monday' }
      let(:movie) do
        {
            name: 'movie name',
            description: 'movie description',
            url: 'movie url'
        }
      end
      it 'returns correct movie data' do
        create(:movie)
        get endpoint + day
        expect(last_response.status).to eq(200)
        expect(JSON.parse(response_body)['movies'][0]['name']).to eq movie[:name]
        expect(JSON.parse(response_body)['movies'][0]['description']).to eq movie[:description]
        expect(JSON.parse(response_body)['movies'][0]['url']).to eq movie[:url]
      end
    end
  end

  context 'POST /api/v1/movies' do
    context 'with valid data' do
      let(:params) do
        {
          name: 'movie_one',
          description: 'terror movie',
          url: 'movie url',
          days: ['monday']
        }
      end
      it 'movie is created' do
        post '/api/v1/movies', params
        expect(last_response.status).to eq(201)
        expect(Movie.count).to eq 1
      end
    end

    context 'with invvalid data' do
      let(:params) do
        {
            name: 'movie_one',
            description: 'terror movie',
            url: 'movie url',
            days: ['falseday']
        }
      end
      it 'movie is not created' do
        post '/api/v1/movies', params
        expect(last_response.status).to eq(400)
        expect(Movie.count).to eq 0
      end
    end
  end
end
