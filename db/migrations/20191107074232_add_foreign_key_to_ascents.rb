Hanami::Model.migration do
  change do
    alter_table(:ascents) do
      add_foreign_key :line_id, :lines
    end
  end
end
