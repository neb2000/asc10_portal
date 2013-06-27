class Forums::CategoryDecorator < Draper::Decorator
  delegate_all
  decorates_association :boards

  def display_name
    source.name
  end
  
  def display_description
    source.description
  end
  
  def display_availability
    return 'Public' if source.public?
    source.user_groups.map(&:name).join(', ')
  end
  
  def self.collection_decorator_class
    PaginatingDecorator
  end
end
