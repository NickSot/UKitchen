class CreateItemsRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :items_recipes do |t|

      t.timestamps
    end
  end
end
