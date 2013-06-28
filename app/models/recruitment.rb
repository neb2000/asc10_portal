class Recruitment < ActiveRecord::Base
  attr_accessible :active, :identifier, :name, :spec
  default_scope ->{ order('recruitments.name') }
  
  validates :spec, presence: true, if: :active?
  
  def self.open_recruitments
    where(active: true)
  end
end
