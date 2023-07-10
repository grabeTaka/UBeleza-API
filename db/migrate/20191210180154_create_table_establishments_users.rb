class CreateTableEstablishmentsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :establishments_users do |t|
      t.belongs_to :establishment, index: true
      t.belongs_to :user, index: true
    end
  end
end
