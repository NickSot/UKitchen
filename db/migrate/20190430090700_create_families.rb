class CreateFamilies < ActiveRecord::Migration[5.2]
  def change
    drop_table :families

    create_table :families do |t|
      t.string :name
      t.integer :administrator_id
      t.decimal :budget, precision: 10, scale: 2, :default => 0.0

      t.timestamps
    end
  end
end
