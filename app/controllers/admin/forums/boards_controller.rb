module Admin
  module Forums
    class BoardsController < Admin::ApplicationController
      respond_to :js, only: [:create, :update, :destroy]
      before_filter { @current_nav_identifier = :forums }
      before_filter :find_board
      authorize_resource class: ::Forums::Board

      def index
        @boards = ::Forums::Board.includes(:category).decorate
        respond_with(@boards)
      end
      
      def new
        @board = ::Forums::Board.new
        respond_with(@board) do |format|
          format.html { render layout: !request.xhr? }
        end
      end
      
      def create
        StandardUpdater.new(StandardResourceDecorator.new(StandardAjaxResponder.new(self))).update(::Forums::Board.new, forums_board_params)
      end
      
      def edit
        respond_with(@board) do |format|
          format.html { render layout: !request.xhr? }
        end
      end
      
      def update
        StandardUpdater.new(StandardResourceDecorator.new(StandardAjaxResponder.new(self))).update(@board, forums_board_params)
      end
      
      def destroy
        StandardDestroyer.new(StandardAjaxResponder.new(self)).destroy(@board)
      end

      private
        def forums_board_params
          params.require(:forums_board).permit!
        end
      
        def find_board
          @board = ::Forums::Board.friendly.find(params[:id]) if params[:id]
        end
    end
  end
end