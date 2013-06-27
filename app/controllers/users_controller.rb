class UsersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json, only: [:ajax_get_users]
  
  def ajax_get_users
    @users = User.where('users.name ilike ?', "%#{params[:query]}%").order(:name).pluck(:name)
    respond_with(@users)
  end
end