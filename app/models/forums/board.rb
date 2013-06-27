# == Schema Information
#
# Table name: forums_boards
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  slug        :string(255)
#  description :text
#  category_id :integer
#  views_count  :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Forums::Board < ActiveRecord::Base
  include Forums::Concerns::Viewable
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  attr_accessible :category_id, :description, :name, :views_count
  
  belongs_to :category, class_name: 'Forums::Category'
  
  has_many :topics, dependent: :destroy
  has_many :posts, through: :topics, dependent: :destroy
  
  validates :category, :name, :description, presence: true
  
  default_scope ->{ order(:id) }
end