# == Schema Information
#
# Table name: forums_posts
#
#  id          :integer          not null, primary key
#  topic_id    :integer
#  user_id     :integer
#  reply_to_id :integer
#  text        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Forums::Post < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_text, against: :text, using: { tsearch: { dictionary: 'english', tsvector_column: 'tsv' } }
  
  belongs_to :topic, class_name: 'Forums::Topic', counter_cache: true
  belongs_to :user, counter_cache: true
  belongs_to :reply_to, class_name: "Forums::Post"
  
  belongs_to :board, class_name: 'Forums::Board', counter_cache: true
  
  acts_as_list scope: :topic

  has_many :replies, class_name: "Forums::Post",
                     foreign_key: "reply_to_id",
                     dependent: :nullify

  validates :text, presence: true  
  
  default_scope -> { order :created_at }
  
  has_paper_trail
  
end