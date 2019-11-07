Hanami::Model.migration do
  change do
    create_table(:lines) do
      primary_key :id

      column :name, String, null: false
      column :grade, String, null: false
      column :crag, String, null: false
      column :kind, String
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
