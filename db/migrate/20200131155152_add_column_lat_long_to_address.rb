class AddColumnLatLongToAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :long, :decimal
    add_column :addresses, :lat, :decimal
  end
end
