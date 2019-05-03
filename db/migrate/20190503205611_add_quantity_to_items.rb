class AddQuantityToItems < ActiveRecord::Migration[5.2]
  def change
    change_table :items do |t|
      t.decimal "quantity", precision: 10, scale: 2
      t.string  "quantity_unit"
    end

  end
end
