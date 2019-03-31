class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password_digest
      #t.integer :family_id

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
