class Admin::RecruitmentsController < Admin::ApplicationController
  before_filter :find_recruitment  
  before_filter { @current_nav_identifier = :recruitments }
  authorize_resource
  
  respond_to :js, only: [:update]
  
  def index
    @recruitments = Recruitment.scoped.decorate
    respond_with(@recruitments)
  end
  
  def edit
    respond_with(@recruitment) do |format|
      format.html { render layout: !request.xhr? }
    end
  end
  
  def update
    StandardUpdater.new(StandardResourceDecorator.new(StandardAjaxResponder.new(self))).update(@recruitment, params[:recruitment])
  end
    
  private
    def find_recruitment
      @recruitment = Recruitment.find(params[:id]) if params[:id]
    end
end