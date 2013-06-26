class BannerImage < ActiveRecord::Base
  attr_accessible :active, :file
  
  mount_uploader :file, BannerImageUploader
  validates :file, presence: true
  
  default_scope -> { order('banner_images.created_at DESC') }
end
