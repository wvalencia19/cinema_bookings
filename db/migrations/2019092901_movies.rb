Sequel.migration do
  change do
    create_table(:movies) do
      primary_key :id
      String :name, size: 25, null: false
      String :description
      String :url
      Integer :days, null: false
      Timestamp :created_at, default: Sequel::CURRENT_TIMESTAMP
      Timestamp :updated_at
    end
  end
end
