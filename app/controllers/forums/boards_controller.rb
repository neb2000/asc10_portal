module Forums
  class BoardsController < ApplicationController
    before_filter :find_board
    authorize_resource
    
    def index
      @categories = Category.accessible_by(current_ability).includes(boards: [:views, {latest_post: [:topic, :user]}]).decorate
    end
    
    def show
      @board.register_view_by(current_user)
      @topics = @board.topics.accessible_by(current_ability).includes(:views, :user, latest_post: [:topic, :user]).by_pinned_or_most_recent_post.page(params[:page]).decorate
      @board = @board.decorate
    end
    
    private
      def find_board
        @board = Board.friendly.find(params[:id]) if params[:id]
      end
  end
end