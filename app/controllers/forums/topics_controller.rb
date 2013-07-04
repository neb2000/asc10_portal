module Forums
  class TopicsController < ApplicationController
    before_filter :find_board, :find_topic
    authorize_resource except: [:new, :create]
    respond_to :html
    
    def new
      authorize! :create_topic, @board if @board
      @topic = Topics::Create::Form.new
      respond_with(@topic)
    end
    
    def create
      StandardUpdater.new(responder).update(Topics::Create::Form.new(board: @board, user: current_user), params[:topic])
    end
    
    def edit
      respond_with(@topic) do |format|
        format.html { render layout: !request.xhr? }
      end
    end
    
    def update
      topic_params = if can?(:move_topic, @topic)
        params.require(:forums_topic).permit(:subject, :board_id)
      else
        params.require(:forums_topic).permit(:subject)
      end
      StandardUpdater.new(TopicPostTsvUpdater.new(responder)).update(@topic, topic_params)
    end
    
    def show
      @topic.register_view_by(current_user)
      @board.register_view_by(current_user)
      @posts = @topic.posts.accessible_by(current_ability).preload(:user, :topic, reply_to: :user).page(params[:page]).decorate
      @topic = @topic.decorate
      respond_with(@topic)
    end
    
    def destroy
      StandardDestroyer.new(responder).destroy(@topic)
    end
    
    def toggle_hide
      responder.redirect_path = url_for(@topic.board)
      StandardUpdater.new(responder).update(@topic, { hidden: !@topic.hidden })
    end
    
    def toggle_lock
      responder.redirect_path = url_for(@topic.board)
      StandardUpdater.new(responder).update(@topic, { locked: !@topic.locked })
    end
    
    def toggle_pin
      responder.redirect_path = url_for(@topic.board)
      StandardUpdater.new(responder).update(@topic, { pinned: !@topic.pinned })
    end
    
    private      
      def responder
        @responder ||= StandardResponder.new(self).tap { |responder| responder.redirect_path = url_for(@board) }
      end
    
      def find_board
        @board = Board.find(params[:board_id]).decorate if params[:board_id]
      end
      
      def find_topic
        @topic = Topic.find(params[:id]) if params[:id]
      end 
  end
end