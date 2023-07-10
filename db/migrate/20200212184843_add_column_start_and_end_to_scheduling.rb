class AddColumnStartAndEndToScheduling < ActiveRecord::Migration[6.0]
  def change
    add_column :schedulings, :start, :datetime
    add_column :schedulings, :end, :datetime
  end
end
