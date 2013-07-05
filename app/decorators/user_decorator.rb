class UserDecorator < Draper::Decorator
  delegate_all
  
  def display_name
    source.name
  end
  
  def display_email
    source.email
  end
  
  def display_gravatar(options = {})
    require 'digest/md5' unless defined?(Digest::MD5)
    md5 = Digest::MD5.hexdigest(source.email.to_s.strip.downcase)
    options[:s] ||= 60
    "#{h.request.ssl? ? 'https://secure' : 'http://www'}.gravatar.com/avatar/#{md5}?#{options.to_param}"
  end
  
  def display_permissions
    h.content_tag :ul, source.permissions.map{ |permission| h.content_tag(:li, permission.name)}.join.html_safe, class: 'unstyled'
  end
  
  def display_user_group
    source.user_group_name
  end
  
  def display_joined_at
    h.l source.created_at, format: :full
  end
  
  def display_last_signed_in
    return 'Never' unless source.last_sign_in_at
    "#{display_last_signed_in_time} - #{source.last_sign_in_ip}"
  end
  
  def display_last_signed_in_time
    return 'Never' unless source.last_sign_in_at
    h.l source.last_sign_in_at, format: :full
  end
  
  def self.collection_decorator_class
    PaginatingDecorator
  end
end