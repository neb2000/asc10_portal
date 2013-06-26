class CreatePermissionsUsersTable < ActiveRecord::Migration
  def change
    create_table :permissions_users, id: false do |t|
      t.integer :permission_id
      t.integer :user_id
    end
    
    add_index :permissions_users, :permission_id
    add_index :permissions_users, :user_id
  end
end