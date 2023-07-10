class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.references :shopping_cart, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.decimal :unit_price
      t.integer :quantity
      t.decimal :total
      t.string :cancel_cause

      t.timestamps
    end
  end
end
