class CreatePasswords < ActiveRecord::Migration
  def change
    create_table :passwords do |t|
      t.string :user
      t.string :server
      t.text :notes

      t.timestamps
    end
  end
end
