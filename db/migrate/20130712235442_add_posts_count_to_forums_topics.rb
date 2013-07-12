class AddPostsCountToForumsTopics < ActiveRecord::Migration
  def change
    add_column :forums_topics, :posts_count, :integer, default: 0
    Forums::Topic.find_each do |topic|
      Forums::Topic.where(id: topic.id).update_all(posts_count: topic.posts.length)
    end
  end
end
