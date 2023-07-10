class AddColumnToSubCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :subcategories, :name, :string
  end
end
