require 'spec_helper'

describe SMSNotification do
  let(:notification) { SMSNotification.new(phone_number, body) }
  let(:phone_number) { '+6021239876' }
  let(:body) { 'Summer sundays, sailing swiftly south' }

  def stub_sms(phone, body)
    url = "https://%s:%s@api.twilio.com/2010-04-01/Accounts/%s/Messages.json" % [
      SMSNotification::ACCOUNT_SID,
      SMSNotification::AUTH_TOKEN,
      SMSNotification::ACCOUNT_SID
    ]
    stub_request(:post, url).
      with(body: {"Body"=>body, "From"=>SMSNotification::FROM_NUMBER, "To"=>phone}).
      to_return(status: 200, body: JSON.generate({}))
  end

  it 'sends an sms notification' do
    stub_sms(phone_number, body)
    notification.call
  end
end
