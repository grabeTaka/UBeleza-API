class AddColumnsTextOneAndTextTwoToEstablishments < ActiveRecord::Migration[6.0]
  def change
    add_column :establishments, :text_one, :string
    add_column :establishments, :text_two, :string
  end
end
