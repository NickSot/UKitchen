class ItemsRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :items_recipes do |t|
      t.integer :recipe_id
      t.integer :item_id
      t.decimal :quantity, :precision => 10, :scale => 2
      t.string :quantity_unit
    end
  end
end
