class Admin::NewsEntriesController < Admin::ApplicationController
  before_filter :find_news_entry
  before_filter { @current_nav_identifier = :news_entries }
  authorize_resource
  
  def index
    @news_entries = NewsEntry.ordered.decorate
    respond_with(@news_entries)
  end
  
  def new
    @news_entry = NewsEntry.new
    respond_with(@news_entry)
  end
    
  def create
    StandardUpdater.new(StandardResponder.new(self)).update(NewsEntry.new, news_entry_params)
  end
  
  def edit
    respond_with(@news_entry)
  end
  
  def update
    StandardUpdater.new(StandardResponder.new(self)).update(@news_entry, news_entry_params)
  end
  
  def destroy
    StandardDestroyer.new(StandardResponder.new(self)).destroy(@news_entry)
  end
  
  private
    def news_entry_params
      params.require(:news_entry).permit!
    end
  
    def find_news_entry
      @news_entry = NewsEntry.friendly.find(params[:id]) if params[:id]
    end
end