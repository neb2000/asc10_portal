class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_message_object
  
  respond_to :html
  respond_to :js, only: [:mark_read_unread, :destroy, :restore]
  
  def index
    @messages = MessageDecorator.decorate_collection current_user.received_messages.preload(:sent_messageable)
    respond_with(@messages)
  end
  
  def sent
    @messages = MessageDecorator.decorate_collection current_user.sent_messages.preload(:received_messageable)
    respond_with(@messages)
  end
  
  def deleted
    @messages = MessageDecorator.decorate_collection current_user.deleted_messages.preload(:sent_messageable, :received_messageable)
    respond_with(@messages)
  end
  
  def show
    authorize! :read, @message_object
    @message_object.mark_as_read
    @message = MessageDecorator.decorate @message_object
    # @quick_reply = Messages::Reply::Form.new(reply_to: @message_object.id, topic: "Re: #{@message_object.topic}")
    respond_with(@message)
  end
  
  def new
    @message = Messages::Compose::Form.new(recipient: params[:recipient])
    respond_with(@message)
  end
  
  def reply
    @message = Messages::Reply::Form.new(reply_to: @message_object.id, topic: "Re: #{@message_object.topic}")
    respond_with(@message)
  end
  
  def create_reply
    @message = Messages::Reply::Form.new(sender: current_user)
    @message.assign_attributes(params[:message])
    respond_to do |format|
      format.html do
        if @message.save
          redirect_to action: :index
        else
          render :reply
        end
      end
    end
  end
  
  def create
    StandardUpdater.new(StandardResponder.new(self)).update(Messages::Compose::Form.new(sender: current_user), params[:message])
  end
  
  def destroy
    authorize! :destroy, @message_object
    current_user.delete_message(@message_object)
    respond_with(@message_object)
  end
  
  def restore
    authorize! :restore, @message_object
    current_user.restore_message(@message_object)
    respond_with(@message_object)
  end
  
  def mark_read_unread
    authorize! :mark_read_unread, @message_object
    StandardUpdater.new(StandardAjaxResponder.new(self)).update(@message_object, opened: params[:read])
  end
  
  private
    def find_message_object
      @message_object = ActsAsMessageable::Message.find(params[:id]) if params[:id]
    end
end