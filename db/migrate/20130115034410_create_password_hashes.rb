class CreatePasswordHashes < ActiveRecord::Migration
  def change
    create_table :password_hashes do |t|
      t.references :user
      t.references :password
      t.string :public_hash

      t.timestamps
    end
    add_index :password_hashes, :user_id
    add_index :password_hashes, :password_id
  end
end
