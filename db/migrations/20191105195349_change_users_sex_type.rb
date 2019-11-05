Hanami::Model.migration do
  change do
    alter_table(:users) do
      set_column_type :sex, TrueClass, using: 'sex::boolean'
    end
  end
end
