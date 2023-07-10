class CreateSubcategories < ActiveRecord::Migration[6.0]
  def change
    create_table :subcategories do |t|
      t.belongs_to :category_type
      t.timestamps
    end
  end
end
