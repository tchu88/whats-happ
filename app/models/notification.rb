# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  event_id        :integer          not null
#  subscription_id :integer          not null
#  format          :string(255)      not null
#  succeeded_at    :datetime
#  created_at      :datetime
#  updated_at      :datetime
#

class Notification < ActiveRecord::Base
  belongs_to :event
  belongs_to :subscription
end
