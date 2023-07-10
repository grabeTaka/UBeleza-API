class CreateShoppingCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :shopping_carts do |t|
      t.references :establishment, null: false, foreign_key: true
      t.references :table, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :status
      t.decimal :total
      t.string :cause

      t.timestamps
    end
  end
end
