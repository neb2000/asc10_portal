class NewsEntriesController < ApplicationController
  respond_to :html
  
  before_filter { @current_nav_identifier = :home }
  
  def index
    @news_entries = NewsEntry.ordered.decorate
    respond_with(@news_entries)
  end
  
  def show
    @news_entry = NewsEntry.find(params[:id]).decorate
    respond_with(@news_entry)
  end
end