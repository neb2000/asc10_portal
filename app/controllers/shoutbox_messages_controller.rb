class ShoutboxMessagesController < ApplicationController
  respond_to :js, only: [:create, :ajax_get_messages]
  
  def ajax_get_messages
    @shoutbox_messages = if request.env['HTTP_USER_AGENT'].downcase =~ /bot/
      ShoutboxMessage.none
    else
      ShoutboxMessage.includes(:user).ordered.limit(50).decorate
    end
    respond_with(@shoutbox_messages)
  end
  
  def create
    message = ShoutboxMessage.new(user: current_user)
    shoutbox_params = params.require(:shoutbox_message).permit(:message)
    StandardUpdater.new(StandardResourceDecorator.new(StandardAjaxResponder.new(self))).update(message, shoutbox_params)
  end
end