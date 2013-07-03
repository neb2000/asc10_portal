class ShoutboxMessagesController < ApplicationController
  respond_to :js, only: [:create]
  
  def create
    message = ShoutboxMessage.new(user: current_user)
    shoutbox_params = params.require(:shoutbox_message).permit(:message)
    StandardUpdater.new(StandardResourceDecorator.new(StandardAjaxResponder.new(self))).update(message, shoutbox_params)
  end
end