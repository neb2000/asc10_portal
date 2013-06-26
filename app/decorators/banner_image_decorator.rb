class BannerImageDecorator < Draper::Decorator
  delegate_all

  def display_large_image
    return if source.file.blank? || source.file.file.blank?
    source.file.url(:large)
  end
  
  def display_thumbnail
    return if source.file.blank? || source.file.file.blank?
    source.file.url(:thumb)
  end
  
  def display_current_banner
    if source.active?
      h.content_tag(:div, h.content_tag(:div, 'Current', class: 'ribbon-green'), class: 'ribbon-wrapper-green', id: 'current-banner-ribbon')
    end
  end
end
