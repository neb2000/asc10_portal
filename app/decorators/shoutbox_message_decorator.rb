class ShoutboxMessageDecorator < Draper::Decorator
  delegate_all
  
  def display_user_name
    source.user_name || 'Guest'
  end
  
  def display_message
    h.emojify(h.auto_link(h.sanitize(source.message), html: { target: '_blank'}))
  end
  
  def display_created_at
    h.l source.created_at, format: :date_and_time
  end
  
  def self.collection_decorator_class
    PaginatingDecorator
  end
end
