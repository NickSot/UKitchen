class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :family_id
      t.string :category_name
      t.decimal :price, precision: 10, scale: 2
      t.string :price_unit

      t.timestamps
    end
  end
end
