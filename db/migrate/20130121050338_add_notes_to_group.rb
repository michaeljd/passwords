class AddNotesToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :notes, :text
  end
end
