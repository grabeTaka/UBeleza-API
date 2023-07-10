class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'citext'

    create_table :products do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 12, scale: 2, null: false
      t.jsonb :details, null: false, default: '{}'
      
      t.timestamps
    end

    add_index :products, :details, using: :gin
  end
end
