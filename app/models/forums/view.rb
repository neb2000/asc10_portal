# == Schema Information
#
# Table name: forums_views
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  viewable_id       :integer
#  viewable_type     :string(255)
#  count             :integer          default(0)
#  current_viewed_at :datetime
#  past_viewed_at    :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Forums::View < ActiveRecord::Base
end
