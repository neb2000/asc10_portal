class ShoutboxMessageDecorator < Draper::Decorator
  delegate_all
  
  def display_user_name
    source.user_name || 'Guest'
  end
  
  def display_message
    h.sanitize source.message
  end
  
  def display_created_at
    h.l source.created_at, format: :date_only
  end
  
end
