# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  name                   :string(255)
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  unconfirmed_email      :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  forem_admin            :boolean          default(FALSE)
#  forem_state            :string(255)      default("pending_review")
#  forem_auto_subscribe   :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  attr_accessible :permission_ids, as: :admin
  # attr_accessible :title, :body
  
  has_and_belongs_to_many :permissions
  
  acts_as_messageable
  
  def permission_identifiers
    @permission_identifiers ||= permissions.pluck(:identifier)
  end
  
  def self.find_by_name(name)
    where(arel_table[:name].matches(name)).first
  end
end
