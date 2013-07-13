class Forums::PostDecorator < Draper::Decorator
  delegate_all
  decorates_association :user
  decorates_association :topic
  decorates_association :reply_to, with: Forums::PostDecorator
  
  def display_subject
    topic.display_subject
  end
  
  def display_board
    topic.display_board
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
  
  def page_number(topic_class = Forums::Post)
    @page_number ||= (source.position.to_f / topic_class.per_page).ceil
  end
  
  def anchor_params
    {anchor: "post-#{source.id}", page: (page_number if page_number > 1)}
  end
  
  def reply_to_link
    reply_to.link_to_topic
  end
  
  def reply_to_anchor
    reply_to.anchor_params
  end
  
  def link_to_topic(options = {})
    h.forums_board_topic_path(source.board_id, source.topic_id, options.merge(anchor_params))
  end
  
  def link_to_topic_without_anchor
    h.forums_board_topic_path(source.board_id, source.topic_id)
  end
  
  def self.collection_decorator_class
    PaginatingDecorator
  end
end