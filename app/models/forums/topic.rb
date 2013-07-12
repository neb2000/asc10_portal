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
  
  include ActiveModel::ForbiddenAttributesProtection
  
  extend FriendlyId
  friendly_id :subject, use: :slugged
  
  belongs_to :board, class_name: 'Forums::Board', counter_cache: true
  belongs_to :user
  has_many :posts, dependent: :destroy, autosave: true
  
  delegate :name, to: :user, prefix: true
  
  validates :subject, :user, :board, :posts, presence: true
  
  def self.search_by_keyword(keyword)
    where("EXISTS (#{Forums::Post.select('NULL').search_by_text(keyword).where('forums_posts.topic_id = forums_topics.id').to_sql})")
  end
  
  def self.by_pinned_or_most_recent_post
    order('forums_topics.id').order('forums_topics.last_post_at DESC').order('forums_topics.pinned DESC')
  end  
end
