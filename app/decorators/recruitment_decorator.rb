class RecruitmentDecorator < Draper::Decorator
  delegate_all
  
  def display_name
    source.name
  end
  
  def display_spec
    source.spec
  end
  
  def display_active
    source.active? ? 'Open' : 'Closed'
  end
  
  def display_css_class
    "class-#{source.identifier}"
  end
  
  def display_class_icon
    h.content_tag(:div, h.content_tag(:div, '', class: 'class-icon'), class: display_css_class)
  end

  def self.collection_decorator_class
    PaginatingDecorator
  end
end