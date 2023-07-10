class AddReferencesToScheduling < ActiveRecord::Migration[6.0]
  def change
    add_column :schedulings, :product_id , :integer, :references => "product"
  end
end
