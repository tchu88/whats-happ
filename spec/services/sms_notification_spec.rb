require 'spec_helper'

describe SMSNotification do
  let(:notification) { SMSNotification.new(phone_number, body) }
  let(:phone_number) { '+6021239876' }
  let(:body) { 'Summer sundays, sailing swiftly south' }

  it 'sends an sms notification' do
    stub_request(:post, "https://fakeaccountsid:fakeauthtoken@api.twilio.com/2010-04-01/Accounts/fakeaccountsid/Messages.json").
      with(body: {"Body"=>body, "From"=>SMSNotification::FROM_NUMBER, "To"=>phone_number}).
      to_return(status: 200, body: JSON.generate({}))

    notification.call
  end
end
