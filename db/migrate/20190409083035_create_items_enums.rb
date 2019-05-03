class CreateItemsEnums < ActiveRecord::Migration[5.2]
  def change
    create_table :items_enums do |t|
      t.string :name

      t.timestamps
    end
  end
end
