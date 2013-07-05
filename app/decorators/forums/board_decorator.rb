class Forums::BoardDecorator < Draper::Decorator
  delegate_all
  decorates_association :category
  decorates_association :posts

  def topics_count
    topics.size
  end
  
  def posts_count
    posts.size
  end

  def display_name
    source.name
  end
  
  def display_description
    source.description
  end
  
  def display_category
    category.display_name
  end
  
  def display_read_only
    h.content_tag(:i, '', class: 'icon-lock text-error', title: 'Read only') if source.read_only?
  end
  
  def display_last_post_link
    return 'None' unless latest_post
    "#{h.link_to latest_post.display_subject, latest_post.link_to_topic} by #{latest_post.display_user} #{latest_post.display_created_at_in_word}".html_safe
  end
  
  def display_class_for(user = nil)
    return unless user && latest_post
    last_viewed = source.views.find{ |view| view.user_id == user.id}.try(:updated_at)
    'has-new-posts' if last_viewed.blank? || last_viewed < latest_post.created_at
  end

  def self.collection_decorator_class
    PaginatingDecorator
  end
  
  private
    def latest_post
      @post_list ||= posts.sort_by(&:created_at)[-1]
    end
end
