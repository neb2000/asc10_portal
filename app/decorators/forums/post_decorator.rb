class Forums::PostDecorator < Draper::Decorator
  delegate_all
  decorates_association :user
  decorates_association :topic
  decorates_association :reply_to, with: Forums::PostDecorator
  
  def display_subject
    topic.display_subject
  end
  
  def display_text
    h.sanitize source.text
  end
  
  def display_user
    user.display_name
  end
  
  def display_reply_to_user
    reply_to.display_user
  end
  
  def display_user_gravatar(options = {})
    user.display_gravatar options
  end
  
  def display_created_at_in_word
    "#{h.time_ago_in_words source.created_at} ago"
  end
  
  def link_to_topic
    h.forums_board_topic_path(topic.board, topic, anchor: "forums_post_#{source.id}", page: topic.last_page)
  end
  
  def self.collection_decorator_class
    PaginatingDecorator
  end
end