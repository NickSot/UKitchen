class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.integer :shopping_list_id
      t.boolean :is_bought
    
      t.timestamps
    end
  end
end
