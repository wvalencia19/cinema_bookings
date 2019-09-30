FactoryBot.define do
  to_create { |i| i.save }
  factory :customer do
    name { 'customer name' }
    document_type  { 'document type' }
    document { 'document' }
  end
end
