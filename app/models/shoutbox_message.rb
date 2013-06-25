class ShoutboxMessage < ActiveRecord::Base
  self.per_page = 100
  
  belongs_to :user
  
  attr_accessible :message, :user_id, :user
  validates :message, presence: true
  
  delegate :name, to: :user, allow_nil: true, prefix: true
  
  def self.ordered
    order('shoutbox_messages.created_at DESC')
  end
end
