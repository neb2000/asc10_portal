class UserDecorator < Draper::Decorator
  delegate_all
  
  def display_name
    source.name
  end
  
  def display_email
    source.email
  end
  
  def display_permissions
    h.content_tag :ul, source.permissions.map{ |permission| h.content_tag(:li, permission.name)}.join.html_safe, class: 'unstyled'
  end
  
  def display_last_signed_in
    return 'Never' unless source.last_sign_in_at
    "#{h.l source.last_sign_in_at, format: :full} - #{source.last_sign_in_ip}"
  end
  
  def self.collection_decorator_class
    PaginatingDecorator
  end
end