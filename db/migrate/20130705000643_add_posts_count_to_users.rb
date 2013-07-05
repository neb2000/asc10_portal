class AddPostsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :posts_count, :integer, default: 0
    User.find_each do |user|
      user.update_column(:posts_count, user.posts.length)
    end
  end
end
