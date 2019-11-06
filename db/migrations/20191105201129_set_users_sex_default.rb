Hanami::Model.migration do
  change do
    alter_table(:users) do
      set_column_default :sex, false
    end
  end
end
