class CreateForumsTopics < ActiveRecord::Migration
  def change
    create_table :forums_topics do |t|
      t.integer :board_id
      t.integer :user_id
      t.string :subject
      t.string :slug
      t.boolean :locked, default: false
      t.boolean :pinned, default: false
      t.boolean :hidden, default: false
      t.datetime :last_post_at
      t.integer :views_count, default: 0

      t.timestamps
    end
    add_index :forums_topics, :board_id
    add_index :forums_topics, :user_id
    add_index :forums_topics, :slug, unique: true
  end
end
