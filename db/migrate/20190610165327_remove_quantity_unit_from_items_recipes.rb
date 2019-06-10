class RemoveQuantityUnitFromItemsRecipes < ActiveRecord::Migration[5.2]
  def change
    change_table :items_recipes do |t|
      t.remove :quantity_unit
    end
  end
end
