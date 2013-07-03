class Admin::UsersController < Admin::ApplicationController
  before_filter :find_user  
  before_filter { @current_nav_identifier = :users }
  authorize_resource
  
  respond_to :js, only: [:update]
  
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
    user_params = params.require(:user).permit(:permission_ids, :user_group_id)
    StandardUpdater.new(StandardResourceDecorator.new(StandardAjaxResponder.new(self))).update(@user, user_params)
  end
  
  def destroy
    StandardDestroyer.new(StandardResponder.new(self)).destroy(@user)
  end
  
  private
    def find_user
      @user = User.find(params[:id]) if params[:id]
    end
  
end