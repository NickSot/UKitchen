class CreateItemsEnums < ActiveRecord::Migration[5.2]
  def change
    create_table :items_enums do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
