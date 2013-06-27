class CreateForumsPosts < ActiveRecord::Migration
  def change
    create_table :forums_posts do |t|
      t.integer :topic_id
      t.integer :user_id
      t.integer :reply_to_id
      t.text :text

      t.timestamps
    end
    add_index :forums_posts, :topic_id
    add_index :forums_posts, :user_id
    add_index :forums_posts, :reply_to_id
  end
end
