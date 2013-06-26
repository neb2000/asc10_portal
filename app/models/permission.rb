class Permission < ActiveRecord::Base
  attr_accessible :identifier, :name
  
  has_and_belongs_to_many :users
end
