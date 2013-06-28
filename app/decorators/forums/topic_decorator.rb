class Forums::TopicDecorator < Draper::Decorator
  delegate_all
  decorates_association :user
  decorates_association :board
  decorates_association :posts
  
  def display_user
    user.display_name
  end
  
  def display_subject
    source.subject
  end
  
  def posts_count
    posts.size
  end
  
  def last_page
    (posts_count / source.class.per_page.to_f).ceil
  end
  
  def display_last_post_at_in_word
    "#{h.time_ago_in_words source.last_post_at} ago"
  end
  
  def display_icon_for(user = nil)
    return h.content_tag(:i, '', class: 'icon-pushpin') if source.pinned
    return h.content_tag(:i, '', class: 'icon-lock text-error') if source.locked
    return unless user
    last_viewed = source.views.find{ |view| view.user_id == user.id}.try(:updated_at)
    if last_viewed.blank? || last_viewed < source.last_post_at
      h.content_tag(:i, '', class: 'icon-file-alt')
    end
  end
  
  def display_last_post_link
    return 'None' if posts.blank?
    "#{h.link_to posts[-1].display_created_at_in_word, h.forums_board_topic_path(board, source, anchor: "forums_post_#{posts[-1].id}", page: last_page)} by #{posts[-1].display_user}".html_safe
  end
  
  def self.collection_decorator_class
    PaginatingDecorator
  end
end