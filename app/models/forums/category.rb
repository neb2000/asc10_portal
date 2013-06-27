# == Schema Information
#
# Table name: forums_categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  slug        :string(255)
#  description :text
#  public      :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Forums::Category < ActiveRecord::Base
  attr_accessible :description, :name, :public, :user_group_ids
  
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :boards
  validates :name, presence: true
  
  has_and_belongs_to_many :user_groups
end
