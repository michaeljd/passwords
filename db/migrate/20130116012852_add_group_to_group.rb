class AddGroupToGroup < ActiveRecord::Migration
  def change
    change_table :groups do |t|
        t.references :group
    end
  end
end
