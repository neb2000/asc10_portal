class SearchesController < ApplicationController
  respond_to :js, only: [:ajax_get_results]
  before_filter { @current_nav_identifier = :search }
  def index    
    @search = Searches::Form.new(params[:q])
    @posts = @search.result(Forums::Post.accessible_by(current_ability).preload({topic: :board}, {reply_to: [topic: :board]}, :user)).page(params[:page]).decorate
  end
  
  def ajax_get_results
    @topics = if params[:keyword].to_s.length > 2
      Forums::Topic.accessible_by(current_ability).search_by_keyword(params[:keyword]).preload(:board).limit(10).decorate
    else
      Forums::Topic.none
    end
    @keyword = params[:keyword]
    respond_with(@topics)
  end  
end