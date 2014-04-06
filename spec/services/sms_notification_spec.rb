require 'spec_helper'

describe SMSNotification do
  let(:notification) { SMSNotification.new(phone_number, body) }
  let(:phone_number) { '+6021239876' }
  let(:body) { 'Summer sundays, sailing swiftly south' }

  it 'sends an sms notification' do
    stub_sms(phone_number, body)
    notification.call
  end
end
