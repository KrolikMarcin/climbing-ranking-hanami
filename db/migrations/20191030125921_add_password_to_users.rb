Hanami::Model.migration do
  change do
    alter_table :users do
      add_column :hashed_pass, String, null: false
    end
  end
end
