class MessageDecorator < Draper::Decorator
  delegate_all
  decorates_association :sent_messageable, with: UserDecorator
  decorates_association :received_messageable, with: UserDecorator
  
  def display_sender
    sent_messageable.blank? ? '-' : sent_messageable.display_name
  end
  
  def display_recipient
    received_messageable.blank? ? '-' : received_messageable.display_name
  end
  
  def display_topic
    source.topic
  end
  
  def display_body
    h.sanitize source.body
  end
  
  def display_truncated_body
    h.sanitize h.truncate_html(source.body, length: 1000)
  end
  
  def display_created_at
    h.l source.created_at, format: :full
  end
  
  def display_unread
    if source.opened
      h.link_to h.content_tag(:i, '', class: 'icon-circle'), h.mark_as_unread_message_path(source), class: 'mark-as-unread', method: :put, remote: true
    else
      h.link_to h.content_tag(:i, '', class: 'icon-circle'), h.mark_as_read_message_path(source), class: 'mark-as-read', method: :put, remote: true
    end
  end
  
  def self.collection_decorator_class
    PaginatingDecorator
  end
end