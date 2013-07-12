class AddTopicsCountToForumsBoards < ActiveRecord::Migration
  def change
    add_column :forums_boards, :topics_count, :integer, default: 0
    # add_column :forums_boards, :posts_count,  :integer, default: 0
    
    Forums::Board.find_each do |board|
      Forums::Board.where(id: board.id).update_all(topics_count: board.topics.length)
    end
    
  end
end
