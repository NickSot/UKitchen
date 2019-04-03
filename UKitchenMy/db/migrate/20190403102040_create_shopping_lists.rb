class CreateShoppingLists < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_lists do |t|
      t.string :name
      t.integer :family_id

      t.timestamps
    end
  end
end
