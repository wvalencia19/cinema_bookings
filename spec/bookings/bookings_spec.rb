require 'spec_helper'
require 'date'
require_relative '../../config/application'

describe Api::Routes do
  let(:today) { Date.today.strftime('%Y-%m-%d') }
  let(:response_body) { last_response.body }
  context 'GET /api/v1/bookings?from=:from&to=:to' do
    let(:yesterday) { Date.today.prev_day.strftime('%Y-%m-%d') }
    let(:from) { yesterday }
    let(:to) { today }
    let(:endpoint) { "/api/v1/bookings?from=#{from}&to=#{to}" }

    let(:booking) do
      {
          booking_date: today
      }
    end

    context 'when there are bookings within the range' do
      it 'returns correct booking data' do
        create(:booking)
        get endpoint
        expect(last_response.status).to eq(200)
        expect(JSON.parse(response_body)['bookings'][0]['booking_date']).to eq booking[:booking_date]
      end
    end

    context 'when there are not bookings within the range' do
      let(:to) { yesterday }
      it 'returns correct booking data' do
        create(:booking)
        get endpoint
        expect(last_response.status).to eq(200)
        expect(JSON.parse(response_body)['bookings']).to eq []
      end
    end
  end

  context 'POST /api/v1/bookings' do
    let(:today_name) { DaysHelper.name_from_date(Date.today) }
    let(:movie) { create(:movie, days: DaysHelper.bit_wise_days_from_day([today_name])) }
    let(:customer) { create(:customer) }
    context 'with valid data' do
      let(:params) do
        {
            movie_id: movie.id,
            customer_id: customer.id,
            date: today
        }
      end
      it 'booking is created' do
        post '/api/v1/bookings', params
        expect(last_response.status).to eq(201)
        expect(Booking.count).to eq 1
      end
    end

    context 'with invvalid data' do
     context 'with invalid movie' do
       let(:params) do
         {
             movie_id: movie.id + 1,
             customer_id: customer.id,
             date: today
         }
       end

       it 'booking is not created' do
         post '/api/v1/bookings', params
         expect(last_response.status).to eq(400)
         expect(response_body).to include Constants::INVALID_MOVIE
       end
     end

     context 'with invalid customer' do
       let(:params) do
         {
             movie_id: movie.id,
             customer_id: customer.id + 1,
             date: today
         }
       end

       it 'booking is not created' do
         post '/api/v1/bookings', params
         expect(last_response.status).to eq(400)
         expect(response_body).to include Constants::CUSTOMER_INVALID
       end
     end

     context 'when maximum of bookings reached' do
       let(:params) do
         {
             movie_id: movie.id,
             customer_id: customer.id,
             date: today
         }
       end

       it 'booking is not created' do
         Constants::MAX_BOOKING_QUOTA.times do
           create(:booking)
         end
         post '/api/v1/bookings', params
         expect(last_response.status).to eq(400)
         expect(response_body).to include Constants::MAX_BOOKINGS_REACHED
       end
     end
    end
  end
end
