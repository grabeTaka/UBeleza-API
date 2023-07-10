class CreateProductsCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :products_categories do |t|
      t.references :product
      t.references :category

      t.timestamps
    end
  end
end
