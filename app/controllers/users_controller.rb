class UsersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, only: [:show]
  respond_to :json, only: [:ajax_get_users]
  
  def show
    @user = User.find(params[:id]).decorate
    respond_with(@user) do |format|
      format.html { render layout: !request.xhr? }
    end
  end
  
  def ajax_get_users
    @users = User.where('users.name ilike ?', "%#{params[:query]}%").order(:name).pluck(:name)
    respond_with(@users)
  end
end