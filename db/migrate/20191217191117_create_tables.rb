class CreateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :tables do |t|
      t.references :establishment, null: false, foreign_key: true
      t.string :name
      t.integer :number
      t.string :token

      t.timestamps
    end
  end
end
