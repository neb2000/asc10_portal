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
  attr_accessible :description, :name, :public
  
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :boards
  validates :name, presence: true
end
