# == Schema Information
#
# Table name: forums_boards
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  slug        :string(255)
#  description :text
#  category_id :integer
#  views_count  :integer         default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Forums::Board < ActiveRecord::Base
  include Forums::Concerns::Viewable
  
  extend FriendlyId
  friendly_id :name, use: :slugged
    
  belongs_to :category, class_name: 'Forums::Category'
  
  has_many :topics, dependent: :destroy
  has_many :posts, dependent: :destroy, class_name: 'Forums::Post'
  
  belongs_to :latest_post, class_name: 'Forums::Post'
  
  has_and_belongs_to_many :managers, join_table: 'boards_managers', association_foreign_key: :manager_id, class_name: 'User'
  
  validates :category, :name, :description, presence: true
  
  default_scope ->{ order('forums_boards.id') }  
  
  def most_recent_post
    @most_recent_post ||= posts.reorder('forums_posts.created_at DESC').first
  end
end
