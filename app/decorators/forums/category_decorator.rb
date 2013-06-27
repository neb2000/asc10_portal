class Forums::CategoryDecorator < Draper::Decorator
  delegate_all
  decorates_association :boards

  def display_name
    source.name
  end
  
  def display_description
    source.description
  end
  
  def display_public
    source.public? ? 'Yes' : 'No'
  end

  def self.collection_decorator_class
    PaginatingDecorator
  end
end
