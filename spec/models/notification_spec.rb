require 'spec_helper'

describe Notification do
  it { should belong_to(:event) }
  it { should belong_to(:subscription) }

  it { 
    subscription = create(:subscription)
    event = create(:event)
    create(:notification, subscription: subscription, event: event)
    should validate_uniqueness_of(:event_id).scoped_to(:subscription_id)
  }
  it { should validate_presence_of(:format) }
  it { should ensure_inclusion_of(:format).in_array(Notification::FORMATS) }
end
