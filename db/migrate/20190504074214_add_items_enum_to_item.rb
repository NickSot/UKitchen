class AddItemsEnumToItem < ActiveRecord::Migration[5.2]
  def change
    change_table :items do |t|
      t.remove :name
      t.integer :items_enum_id
    end
  end
end
