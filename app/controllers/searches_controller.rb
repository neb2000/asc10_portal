class SearchesController < ApplicationController
  respond_to :js, only: [:ajax_get_results]
  before_filter { @current_nav_identifier = :search }
  def index
    @categories = Forums::Category.accessible_by(current_ability).includes(:boards).to_a
    
    @search = Searches::Form.new(params[:q])
    @posts = @search.result(Forums::Post.accessible_by(current_ability)).page(params[:page]).decorate
  end
  
  def ajax_get_results
    @posts = if params[:keyword].to_s.length > 2
      Forums::Post.accessible_by(current_ability).search_by_text(params[:keyword]).preload(topic: :board).limit(10).decorate
    else
      Forums::Post.none
    end
    @keyword = params[:keyword]
    respond_with(@posts)
  end  
end