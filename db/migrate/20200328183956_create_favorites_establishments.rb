class CreateFavoritesEstablishments < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites_establishments do |t|
      t.belongs_to :establishment
      t.belongs_to :user
      t.timestamps
    end
  end
end
