# == Schema Information
#
# Table name: forums_topics
#
#  id           :integer          not null, primary key
#  board_id     :integer
#  user_id      :integer
#  subject      :string(255)
#  slug         :string(255)
#  locked       :boolean          default(FALSE)
#  pinned       :boolean          default(FALSE)
#  hidden       :boolean          default(FALSE)
#  last_post_at :datetime
#  views_count  :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Forums::Topic < ActiveRecord::Base
  include Forums::Concerns::Viewable
  
  attr_accessible :board_id, :board, :user, :user_id, :subject, :last_post_at
  attr_accessible :locked, :pinned, :hidden, as: :admin
  
  extend FriendlyId
  friendly_id :subject, use: :slugged
  
  belongs_to :board, class_name: 'Forums::Board'
  belongs_to :user
  has_many :posts, dependent: :destroy, order: 'forums_posts.created_at'
  
  validates :subject, :user, :board, :posts, presence: true
  
  def self.by_pinned_or_most_recent_post
    order('forums_topics.id').order('forums_topics.last_post_at DESC').order('forums_topics.pinned DESC')
  end
  
end
