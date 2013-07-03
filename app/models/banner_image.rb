# == Schema Information
#
# Table name: banner_images
#
#  id         :integer          not null, primary key
#  file       :string(255)
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BannerImage < ActiveRecord::Base
  mount_uploader :file, BannerImageUploader
  validates :file, presence: true
  
  default_scope -> { order('banner_images.created_at DESC') }
end
