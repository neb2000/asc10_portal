class ShoutboxMessagesController < ApplicationController
  respond_to :js, only: [:index, :create]
  
  def index
    @shoutbox_messages = ShoutboxMessage.ordered.page(params[:page]).decorate
    respond_with(@shoutbox_messages)
  end
  
  def create
    message = ShoutboxMessage.new(user: current_user)
    StandardUpdater.new(StandardResourceDecorator.new(StandardAjaxResponder.new(self))).update(message, params[:shoutbox_message])
  end
end