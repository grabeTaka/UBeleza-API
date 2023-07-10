class RemoveColumnsFromEstablishment < ActiveRecord::Migration[6.0]
  def change
    remove_column :establishments, :text_one, :string
    remove_column :establishments, :text_two, :string
  end
end
