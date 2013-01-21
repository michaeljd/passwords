class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name

      t.timestamps
    end

    create_table :groups_users, :id =>false do |t|
        t.integer :group_id
        t.integer :user_id
    end

    create_table :groups_passwords, :id =>false do |t|
        t.integer :group_id
        t.integer :password_id
    end
  end
end
