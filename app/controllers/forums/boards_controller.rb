module Forums
  class BoardsController < ApplicationController
    before_filter :find_board
    authorize_resource
    
    def index
      @categories = Category.accessible_by(current_ability).includes(boards: [:views, {posts: [:user, :topic]}]).decorate
    end
    
    def show
      @board.register_view_by(current_user)
      @topics = @board.topics.accessible_by(current_ability).includes(:views, :user, :board, posts: :user).by_pinned_or_most_recent_post.page(params[:page]).decorate
      @board = @board.decorate
    end
    
    private
      def find_board
        @board = Board.find(params[:id]) if params[:id]
      end
  end
end