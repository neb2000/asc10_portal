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
  
  def display_last_post_link
    return 'None' if posts.blank?
    "#{h.link_to posts[-1].display_subject, posts[-1].link_to_topic} by #{posts[-1].display_user} #{posts[-1].display_created_at_in_word}".html_safe
  end

  def self.collection_decorator_class
    PaginatingDecorator
  end
end
