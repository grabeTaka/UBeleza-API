class AddRelationBtwProductsAndSubcategories < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :subcategory_id , :integer, :references => "subcategory"
  end
end
