class UserGroup < ActiveRecord::Base
  has_many :users
  has_and_belongs_to_many :categories, class_name: 'Forums::Category', join_table: 'categories_user_groups'
  
  def readable_category_ids
    @readable_category_ids ||= category_ids
  end
end
