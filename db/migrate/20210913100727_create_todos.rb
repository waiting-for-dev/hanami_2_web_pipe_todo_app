# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table(:todos) do
      primary_key :id
      column :title, String, null: false
      column :description, String, null: false
    end
  end
end
