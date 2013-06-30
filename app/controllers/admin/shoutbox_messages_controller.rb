class Admin::ShoutboxMessagesController < Admin::ApplicationController
  before_filter :find_shoutbox_messages
  before_filter { @current_nav_identifier = :shoutbox_messages }
  authorize_resource
  
  respond_to :js, only: [:index, :destroy]
  
  def index
    @shoutbox_messages = ShoutboxMessage.ordered.includes(:user).page(params[:page]).per_page(30).decorate
    respond_with(@shoutbox_messages)
  end
  
  def destroy
    StandardDestroyer.new(StandardAjaxResponder.new(self)).destroy(@shoutbox_message)
  end
  
  private
    def find_shoutbox_messages
      @shoutbox_message = ShoutboxMessage.find(params[:id]) if params[:id]
    end
end