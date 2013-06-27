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
  
  def display_last_post_link
    return 'None' if posts.blank?
    "#{h.link_to posts[-1].display_created_at_in_word, posts[-1].link_to_topic} by #{posts[-1].display_user}".html_safe
  end
  
  def self.collection_decorator_class
    PaginatingDecorator
  end
end