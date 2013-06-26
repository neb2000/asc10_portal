class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :identifier
      t.string :name

      t.timestamps
    end
    add_index :permissions, :identifier
  end
end
