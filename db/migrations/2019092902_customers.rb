Sequel.migration do
  change do
    create_table(:customers) do
      primary_key :id
      String :name, size: 50
      String :document_type, size: 20
      String :document, size: 20
      Timestamp :created_at, default: Sequel::CURRENT_TIMESTAMP
      Timestamp :updated_at
    end
  end
end
