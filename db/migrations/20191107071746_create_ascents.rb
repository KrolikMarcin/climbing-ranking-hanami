Hanami::Model.migration do
  change do
    create_table(:ascents) do
      primary_key :id

      column :style, String, null: false
      column :date, Date, null: false
      column :kind, String, null: false
      column :belayer, String
      column :points, Integer
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
      foreign_key :user_id, :users
    end
  end
end
