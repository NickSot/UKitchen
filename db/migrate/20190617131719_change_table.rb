class ChangeTable < ActiveRecord::Migration[5.2]
  def change
    change_table :items_recipes do |t|
      t.remove :recipe_text
    end
  end
end
