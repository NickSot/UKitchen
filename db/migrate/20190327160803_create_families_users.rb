class CreateFamiliesUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :families_users do |t|
    	t.integer :user_id
    	t.integer :family_id
      t.timestamps
    end
  end
end
