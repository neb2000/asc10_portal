class Admin::PagesController < Admin::ApplicationController
  before_filter :find_page  
  before_filter { @current_nav_identifier = :pages }
  
  def index
    @pages = Page.ordered.decorate
    respond_with(@pages)
  end
  
  def new
    @page = Page.new
    respond_with(@page)
  end
    
  def create
    StandardUpdater.new(StandardResponder.new(self)).update(Page.new, params[:page])
  end
  
  def edit
    respond_with(@page)
  end
  
  def update
    StandardUpdater.new(StandardResponder.new(self)).update(@page, params[:page])
  end
  
  def destroy
    StandardDestroyer.new(StandardResponder.new(self)).destroy(@page)
  end
  
  private
    def find_page
      @page = Page.find(params[:id]) if params[:id]
    end
end