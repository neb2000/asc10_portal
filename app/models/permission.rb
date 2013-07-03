# == Schema Information
#
# Table name: permissions
#
#  id         :integer          not null, primary key
#  identifier :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Permission < ActiveRecord::Base
  has_and_belongs_to_many :users
end
