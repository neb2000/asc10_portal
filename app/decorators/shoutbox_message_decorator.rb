class ShoutboxMessageDecorator < Draper::Decorator
  delegate_all
  
  def display_user_name
    source.user_name || 'Guest'
  end
  
  def display_message
    h.emojify(h.sanitize source.message)
  end
  
  def display_created_at
    h.l source.created_at, format: :date_and_time
  end
  
  def self.collection_decorator_class
    PaginatingDecorator
  end
end
