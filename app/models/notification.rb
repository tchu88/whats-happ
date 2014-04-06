class Notification < ActiveRecord::Base
  FORMATS = %w(sms)

  belongs_to :event
  belongs_to :subscription

  validates_presence_of :format
  validates_inclusion_of :format, in: FORMATS
  validates_uniqueness_of :event_id, scope: :subscription_id
end