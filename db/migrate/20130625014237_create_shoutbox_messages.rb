class CreateShoutboxMessages < ActiveRecord::Migration
  def change
    create_table :shoutbox_messages do |t|
      t.integer :user_id
      t.text :message

      t.timestamps
    end
    add_index :shoutbox_messages, :user_id
  end
end
