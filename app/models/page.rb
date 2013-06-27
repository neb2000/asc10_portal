# == Schema Information
#
# Table name: pages
#
#  id                  :integer          not null, primary key
#  title               :string(255)
#  slug                :string(255)
#  content             :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  display_shoutbox    :boolean          default(TRUE)
#  display_recruitment :boolean          default(TRUE)
#

class Page < ActiveRecord::Base
  attr_accessible :title, :content, :display_shoutbox, :display_recruitment
  
  include Bootsy::Container
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  validates :title, :content, presence: true
  
  def self.ordered
    order(:title)
  end
  
  def should_generate_new_friendly_id?
    new_record?
  end
end
