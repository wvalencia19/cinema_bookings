Sequel.migration do
  change do
    create_table(:bookings) do
      primary_key :id
      foreign_key :movie_id, :movies, key: :id
      foreign_key :customer_id, :customers, key: :id
      Date :date
      Timestamp :created_at, default: Sequel::CURRENT_TIMESTAMP
      Timestamp :updated_at
    end
  end
end
