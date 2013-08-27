class Admin::UsersController < Admin::ApplicationController
  before_filter :find_user  
  before_filter { @current_nav_identifier = :users }
  authorize_resource
  
  respond_to :js, only: [:update]
  
  def index
    @users = User.includes(:permissions, :user_group).page(params[:page]).decorate
    respond_with(@users)
  end
  
  def edit
    respond_with(@user) do |format|
      format.html { render layout: !request.xhr? }
    end
  end
  
  def update
    user_params = if can?(:manage, Permission)
      params.require(:user).permit(:user_group_id, permission_ids: [])
    else
      params.require(:user).permit(:user_group_id)
    end
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