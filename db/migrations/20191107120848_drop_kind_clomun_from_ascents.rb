Hanami::Model.migration do
  change do
    alter_table(:ascents) do
      drop_column :kind
    end
  end
end
