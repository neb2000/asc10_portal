class NewsEntriesController < ApplicationController
  respond_to :html
  
  before_filter { @current_nav_identifier = :home }
  
  def index
    @news_entries = NewsEntry.paginate(per_page: 7, page: params[:page]).ordered.decorate
    respond_with(@news_entries)
  end
  
  def show
    @news_entry = NewsEntry.friendly.find(params[:id]).decorate
    respond_with(@news_entry) if stale? @news_entry
  end
end