class AddUserGroupIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_group_id, :integer
    add_index :users, :user_group_id
  end
end
