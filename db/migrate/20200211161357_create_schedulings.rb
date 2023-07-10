class CreateSchedulings < ActiveRecord::Migration[6.0]
  def change
    create_table :schedulings do |t|
      t.belongs_to :establishment
      t.belongs_to :user
      t.string :schedule
      t.timestamps
    end
  end
end
