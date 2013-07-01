class SearchesController < ApplicationController
  respond_to :js, only: [:ajax_get_results]
  before_filter { @current_nav_identifier = :search }
  def index
    @categories = Forums::Category.accessible_by(current_ability).includes(:boards).to_a
    
    @search = Searches::Form.new(params[:q])
    @posts = @search.result(Forums::Post.accessible_by(current_ability)).page(params[:page]).decorate
  end
  
  def ajax_get_results
    @topics = if params[:keyword].to_s.length > 2
      Forums::Topic.accessible_by(current_ability).where("EXISTS (#{Forums::Post.search_by_text(params[:keyword]).where('forums_posts.topic_id = forums_topics.id').to_sql})").preload(:board).limit(10).decorate
    else
      Forums::Topic.none
    end
    @keyword = params[:keyword]
    respond_with(@topics)
  end  
end