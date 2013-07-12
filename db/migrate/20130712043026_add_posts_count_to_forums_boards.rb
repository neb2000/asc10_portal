class AddPostsCountToForumsBoards < ActiveRecord::Migration
  def change
    add_column :forums_boards, :posts_count, :integer, default: 0
    Forums::Board.find_each do |board|
      Forums::Board.where(id: board.id).update_all(posts_count: board.posts.length)
    end
  end
end
