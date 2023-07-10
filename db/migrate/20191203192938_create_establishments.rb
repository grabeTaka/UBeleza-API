class CreateEstablishments < ActiveRecord::Migration[6.0]
  def change
    create_table :establishments do |t|
      t.string :name
      t.jsonb :details, default: '{}'

      t.timestamps
    end
  end
end
