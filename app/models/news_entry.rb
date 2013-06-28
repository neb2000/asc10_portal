# == Schema Information
#
# Table name: news_entries
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  slug        :string(255)
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  cover_image :string(255)
#

class NewsEntry < ActiveRecord::Base
  attr_accessible :title, :content, :cover_image
  mount_uploader :cover_image, CoverImageUploader
  

  extend FriendlyId
  friendly_id :title, use: :slugged
  
  validates :title, :content, presence: true
  
  def self.ordered
    order('news_entries.created_at DESC')
  end
  
  def should_generate_new_friendly_id?
    new_record?
  end
end
