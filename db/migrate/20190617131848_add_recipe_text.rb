class AddRecipeText < ActiveRecord::Migration[5.2]
  def change
    change_table :recipes do |t|
      t.string :text
    end
  end
end
