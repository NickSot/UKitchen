class CreateItemsRecipes < ActiveRecord::Migration[5.2]
  def change
    drop_table :items_recipes

    create_table :items_recipes do |t|
      t.integer :recipe_id
      t.integer :items_enum_id
      t.decimal :quantity, :precision => 10, :scale => 2
      t.string :quantity_unit

      t.timestamps
    end
  end
end
