class ShoutboxMessagesController < ApplicationController
  respond_to :js, only: [:create]
  
  def create
    message = ShoutboxMessage.new(user: current_user)
    StandardUpdater.new(StandardResourceDecorator.new(StandardAjaxResponder.new(self))).update(message, params[:shoutbox_message])
  end
end