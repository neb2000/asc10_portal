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
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  attr_accessible :permission_ids, :user_group_id, as: :admin
  # attr_accessible :title, :body
  
  belongs_to :user_group
  
  has_and_belongs_to_many :permissions
  has_and_belongs_to_many :managed_boards, join_table: 'boards_managers', foreign_key: :manager_id, class_name: 'Forums::Board'
  
  has_many :topics, class_name: 'Forums::Topic'
  has_many :posts, class_name: 'Forums::Post'
  
  delegate :name, to: :user_group, allow_nil: true, prefix: true
  delegate :readable_category_ids, to: :user_group, allow_nil: true
  
  validates :name, presence: true
  
  def managed_board_id_list
    @managed_board_id_list ||= managed_board_ids
  end
  
  acts_as_messageable
  
  def permission_identifiers
    @permission_identifiers ||= permissions.pluck(:identifier)
  end
  
  def self.find_by_name(name)
    where(arel_table[:name].matches(name)).first
  end
end
