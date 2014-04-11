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

require 'spec_helper'

describe Notification do
  it { should belong_to(:event) }
  it { should belong_to(:subscription) }
end
