class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|

      t.string :cep
      t.string :city
      t.string :neighborhood
      t.string :street
      t.string :number
      t.string :complement
      t.string :uf
      t.string :district
      t.string :state

      t.belongs_to :establishment
      t.timestamps
    end
  end
end
