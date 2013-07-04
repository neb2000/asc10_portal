class AddPositionToForumsPost < ActiveRecord::Migration
  def change
    add_column :forums_posts, :position, :integer
    
    Forums::Topic.includes(:posts).find_each do |topic|
      topic.posts.each_with_index do |post, index|
        post.update_attributes(position: (index + 1))
      end
    end
  end
end
