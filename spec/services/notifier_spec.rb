require 'spec_helper'

describe Notifier do
  let(:notifier) { Notifier.new(event) }
  let!(:event) { create(:event, message: message, latitude: latitude, longitude: longitude) }
  let!(:containing_subscription) { create(:subscription, phone: '555-555-5555', latitude: 35.2221428, longitude: -80.8390033, radius: 500) }
  let!(:other_subscription) { create(:subscription, phone: '444-444-4444', latitude: 35.223177, longitude: -80.810581, radius: 500) }
  let(:message) { 'hello human' }
  let(:latitude) { 35.221277 }
  let(:longitude) { -80.839268 }

  it 'sends the event message to subscribers with areas containing the event coordinates' do
    expect(notifier).to receive(:send_message).with(instance_of(Notification), containing_subscription.phone, message)
    expect(notifier).not_to receive(:send_message).with(instance_of(Notification), other_subscription.phone, message)

    notifier.call
  end

  it 'creates a notification record' do
    stub_sms(containing_subscription.phone, message)

    expect { notifier.call }.to change{ Notification.count }.by(+1)
  end

  it 'does not send messages to unsubscribed phone numbers' do
    subscription = create(:subscription, unsubscribed_at: Time.now, phone: '333-333-333', latitude: 35.2221428, longitude: -80.8390033, radius: 500)
    expect(notifier).not_to receive(:send_message).with(subscription.phone, message)
    notifier.call
  end
end
