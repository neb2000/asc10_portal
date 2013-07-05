class PagesController < ApplicationController
  respond_to :html
  
  def show
    @page = Page.friendly.find(params[:id]).decorate
    respond_with(@page)
  end
end