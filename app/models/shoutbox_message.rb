# == Schema Information
#
# Table name: shoutbox_messages
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShoutboxMessage < ActiveRecord::Base
  self.per_page = 100
  
  belongs_to :user  
  validates :message, presence: true
  
  delegate :name, to: :user, allow_nil: true, prefix: true
  
  def self.ordered
    order('shoutbox_messages.created_at DESC')
  end
end
