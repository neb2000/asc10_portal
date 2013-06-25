class NewsEntry < ActiveRecord::Base
  attr_accessible :title, :content, :cover_image
  mount_uploader :cover_image, CoverImageUploader
  
  include Bootsy::Container
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
