class NewsEntryDecorator < Draper::Decorator
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
  
  def display_created_at
    h.l source.created_at, format: :full
  end
  
  def display_cover_image(version = :small, options = { width: 234, height: 117 })
    return if source.cover_image.blank? || source.cover_image.file.blank?
    h.content_tag :div, h.image_tag(source.cover_image.url(version), options.merge(itemprop: 'image')), class: 'cover-image'
  end
  
  def display_date_published
    h.l source.created_at, format: :microdata
  end
  
  def self.collection_decorator_class
    PaginatingDecorator
  end
end