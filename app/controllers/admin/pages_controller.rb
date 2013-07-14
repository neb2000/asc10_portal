class Admin::PagesController < Admin::ApplicationController
  before_filter :find_page  
  before_filter { @current_nav_identifier = :pages }
  before_filter :expire_cache, only: [:create, :update, :destroy]
  authorize_resource
  
  def index
    @pages = Page.ordered.decorate
    respond_with(@pages)
  end
  
  def new
    @page = Page.new
    respond_with(@page)
  end
    
  def create
    StandardUpdater.new(StandardResponder.new(self)).update(Page.new, page_params)
  end
  
  def edit
    respond_with(@page)
  end
  
  def update
    StandardUpdater.new(StandardResponder.new(self)).update(@page, page_params)
  end
  
  def destroy
    StandardDestroyer.new(StandardResponder.new(self)).destroy(@page)
  end
  
  private
    def page_params
      params.require(:page).permit!
    end
  
    def find_page
      @page = Page.friendly.find(params[:id]) if params[:id]
    end
    
    def expire_cache
      expire_fragment /all_pages\/*/
    end
end