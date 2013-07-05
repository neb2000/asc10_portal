class AddPostsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :posts_count, :integer, default: 0
    User.find_each do |user|
      User.where(id: user.id).update_all(:posts_count, user.posts.length)
    end
  end
end
