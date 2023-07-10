class AddRelationProductsEstablishments < ActiveRecord::Migration[6.0]
  def change
    change_table :products do |t|
      t.references :establishment
    end
  end
end
