class CreateSystemSettings < ActiveRecord::Migration
  def change
    create_table :system_settings do |t|
      t.string :identifier, null: false
      t.string :description
      t.text :metadata

      t.timestamps
    end
    add_index :system_settings, :identifier, unique: true
  end
end
