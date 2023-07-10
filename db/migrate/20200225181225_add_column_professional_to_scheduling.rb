class AddColumnProfessionalToScheduling < ActiveRecord::Migration[6.0]
  def change
    add_reference :schedulings, :professional, foreign_key: { to_table: :users }
  end
end
