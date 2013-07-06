module Forums
  class PostsController < ApplicationController
    before_filter :find_topic, :find_post, :find_reply_to
    respond_to :html
    
    def new
      @post = @topic.posts.build(reply_to: @reply_to)
      @topic = @topic.decorate
      if params[:quote] && @reply_to
        @post.text = "<blockquote>#{@reply_to.decorate.display_text}</blockquote><br>"
      end
      respond_with(@post)
    end
    
    def create
      @topic = @topic.decorate
      StandardUpdater.new(TopicPostTimeSetter.new(responder)).update(@topic.posts.build(user: current_user), forums_post_params)
    end
    
    def edit
      @topic = @topic.decorate
      respond_with(@post)
    end
    
    def update
      @topic = @topic.decorate
      StandardUpdater.new(responder).update(@post, forums_post_params)
    end
    
    def destroy
      if @post.position == 1
        responder.redirect_path = url_for(@topic.board)
        StandardDestroyer.new(responder).destroy(@topic)
      else
        StandardDestroyer.new(responder).destroy(@post)
      end
    end
    
    private
      def forums_post_params
        params.require(:forums_post).permit(:text, :reply_to_id)
      end
    
      def responder
        @responder ||= StandardResponder.new(self).tap { |responder| responder.redirect_path = forums_board_topic_path(@topic.board, @topic) }
      end
      
      def find_post
        @post ||= Post.friendly.find(params[:id]) if params[:id]
      end
    
      def find_reply_to
        @reply_to ||= Post.find(params[:reply_to_id]) if params[:reply_to_id]
      end
      
      def find_topic
        @topic = Topic.friendly.find(params[:topic_id]) if params[:topic_id]
      end
  end
end