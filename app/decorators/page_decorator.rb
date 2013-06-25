class PageDecorator < Draper::Decorator
  delegate_all
  
  def display_title
    source.title
  end
  
  def display_content
    h.sanitize source.content
  end
  
  def display_truncated_content
    h.sanitize h.truncate_html(source.content, length: 1000, omission: h.link_to(' ...Click here for more', source, class: 'read-more-link'))
  end
end