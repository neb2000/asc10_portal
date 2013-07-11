class SitemapsController < ApplicationController
  
  respond_to :xml
  
  def show
    @news_entries = NewsEntry.ordered
    respond_with(@news_entries)
  end
end