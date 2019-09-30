FactoryBot.define do
  to_create { |i| i.save }
  factory :movie do
    name { 'movie name' }
    description  { 'movie description' }
    url { 'movie url' }
    days { 1 }
  end
end
