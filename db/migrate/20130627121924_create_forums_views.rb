class CreateForumsViews < ActiveRecord::Migration
  def change
    create_table :forums_views do |t|
      t.integer :user_id
      t.integer :viewable_id
      t.string :viewable_type
      t.integer :count, default: 0
      t.datetime :current_viewed_at
      t.datetime :past_viewed_at

      t.timestamps
    end
    add_index :forums_views, :user_id
    add_index :forums_views, :viewable_id
  end
end
