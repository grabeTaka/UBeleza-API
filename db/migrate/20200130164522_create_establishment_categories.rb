class CreateEstablishmentCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :establishment_categories do |t|
      t.belongs_to :establishment
      t.belongs_to :category_type
      t.timestamps
    end
  end
end
