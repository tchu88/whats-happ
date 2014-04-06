class SMSNotification < Struct.new(:phone_number, :body)
  ACCOUNT_SID = ENV.fetch('TWILIO_ACCOUNT_SID').freeze
  AUTH_TOKEN = ENV.fetch('TWILIO_AUTH_TOKEN').freeze
  FROM_NUMBER = ENV.fetch('TWILIO_FROM_NUMBER').freeze

  def call
    client.account.messages.create(from: FROM_NUMBER, to: phone_number, body: body)
  end

  def client
    @client ||= Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
  end
end
