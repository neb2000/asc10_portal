class Forums::TopicDecorator < Draper::Decorator
  delegate_all
  decorates_association :user
  decorates_association :board
  decorates_association :posts
  decorates_association :latest_post, with: Forums::PostDecorator
  
  def display_user
    user.display_name
  end
  
  def display_board
    board.display_name
  end
  
  def display_subject
    source.subject
  end
  
  def display_truncated_subject
    h.truncate source.subject, length: 50
  end
  
  def posts_count
    source.posts.size
  end
  
  def last_page
    (posts_count / source.class.per_page.to_f).ceil
  end
  
  def display_lock_action
    (source.locked? ? "#{h.content_tag :i, '', class: 'icon-unlock'} Unlock"  : "#{h.content_tag :i, '', class: 'icon-lock'} Lock").html_safe
  end
  
  def display_hide_action
    (source.hidden? ? "#{h.content_tag :i, '', class: 'icon-eye-open'} Show"  : "#{h.content_tag :i, '', class: 'icon-eye-close'} Hide").html_safe
  end
  
  def display_pin_action
    (source.pinned? ? "#{h.content_tag :i, '', class: 'icon-pushpin'} Unstick"  : "#{h.content_tag :i, '', class: 'icon-pushpin'} Stick").html_safe
  end
  
  def display_last_post_at_in_word
    "#{h.time_ago_in_words source.last_post_at} ago"
  end
  
  def display_icon_for(user = nil)
    return h.content_tag(:i, '', class: 'icon-pushpin', title: 'Sticky') if source.pinned
    return h.content_tag(:i, '', class: 'icon-lock text-error', title: 'Locked') if source.locked
    return h.content_tag(:i, '', class: 'icon-eye-close text-warning', title: 'Hidden') if source.hidden
    return unless user
    last_viewed = source.views.find{ |view| view.user_id == user.id}.try(:updated_at)
    if last_viewed.blank? || last_viewed < source.last_post_at
      h.content_tag(:i, '', class: 'icon-file-alt', title: 'New post')
    end
  end
  
  def display_go_to_page_link(klass = Forums::Post)
    return unless source.posts.size > klass.per_page
    page_list = (1..(source.posts.size.to_f / klass.per_page).ceil).to_a
    links = if page_list.size < 6
      to_page_link(page_list)
    else
      "#{to_page_link(page_list[0,  2])} &hellip; #{to_page_link(page_list[-3, 3])}".html_safe
    end    
    h.content_tag :p, h.content_tag(:small, "Go to page: #{links}".html_safe), class: 'no-whitespace muted'
  end
  
  def to_page_link(pages)
    return if pages.blank?
    pages.map do |page_number|
      h.link_to(page_number, h.forums_board_topic_path(source.board_id, source, page: page_number))
    end.join(', ').html_safe
  end
  
  def display_last_post_link
    return 'None' unless latest_post
    "#{h.link_to latest_post.display_created_at_in_word, display_recent_post_link}<br>by #{latest_post.display_user}".html_safe
  end
  
  def display_recent_post_link
    h.forums_board_topic_path(source.board_id, source, latest_post.anchor_params)
  end
  
  def self.collection_decorator_class
    PaginatingDecorator
  end
  
  # private
  #   def latest_post
  #     @post_list ||= posts.sort_by(&:created_at)[-1]
  #   end
end