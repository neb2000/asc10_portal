module ApplicationHelper
  def faye_url
    @faye_url ||= FAYE_CONFIG['url']
  end
      
  def broadcast(channel, &block)
    message = {channel: channel, data: capture(&block), ext: { auth_token: FAYE_CONFIG['token'], app_name: FAYE_CONFIG['app_name'] } }
    uri = URI.parse("#{faye_url}/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end
  
  def main_content_class
    if content_for?(:left_sidebar) && content_for?(:right_sidebar)
      'span6 left-bordered right-bordered'
    elsif content_for?(:left_sidebar)
      'span9 left-bordered'
    elsif content_for?(:right_sidebar)
      'span9 right-bordered'
    else
      'span12'
    end
  end
  
  def display_sidebars
    display_left_sidebar
    display_right_sidebar
  end
  
  def display_left_sidebar
    content_for(:left_sidebar, render('left_sidebar'))
  end
  
  def display_right_sidebar
    content_for(:right_sidebar, render('right_sidebar')) 
  end
    
  def latest_forum_topics
    @latest_forum_topics ||= Forums::Topic.accessible_by(current_ability).order('forums_topics.last_post_at DESC').includes(:latest_post).limit(5).decorate
  end
  
  def open_recruitments
    @open_recruitments ||= Recruitment.open_recruitments.decorate
  end
  
  def recruitment_status
    open_recruitments.present? ? 'Open' : 'Closed'
  end
  
  def dismiss_modal_button(text = 'Close', &block)
    link_text = block_given? ? capture(&block) : text
    link_to link_text, '#', class: 'btn', data: { dismiss: 'modal' }
  end
  
  def current_banner_image
    @banner_image ||= Rails.cache.fetch('banner_image') do
      BannerImage.where(active: true).decorate.first.try(:display_large_image) || 'banner_green.png'
    end
  end
  
  def unread_message_count
    @unread_message_count ||= current_user.received_messages.unreaded.size
  end
  
  def unread_message_badge
    if unread_message_count > 0
      content_tag(:span, unread_message_count, class: 'label label-important')
    end
  end
  
end
