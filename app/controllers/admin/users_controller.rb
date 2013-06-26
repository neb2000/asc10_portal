class Admin::UsersController < Admin::ApplicationController
  before_filter :find_user  
  before_filter { @current_nav_identifier = :users }
  authorize_resource
  
  def index
    @users = User.includes(:permissions).page(params[:page]).decorate
    respond_with(@users)
  end
  
  def edit
    respond_with(@user) do |format|
      format.html { render layout: !request.xhr? }
    end
  end
  
  def update
    StandardUpdater.new(StandardResourceDecorator.new(StandardAjaxResponder.new(self))).update(@user, params[:user], :admin)
  end
  
  def destroy
    StandardDestroyer.new(StandardResponder.new(self)).destroy(@user)
  end
  
  private
    def find_user
      @user = User.find(params[:id]) if params[:id]
    end
  
end