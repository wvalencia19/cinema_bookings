require 'date'

FactoryBot.define do
  to_create { |i| i.save }
  factory :booking do
    date { Date.today }
    movie
    customer
  end
end
