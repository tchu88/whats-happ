module TwilioHelper
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
end

RSpec.configure do |config|
  config.include TwilioHelper
end
