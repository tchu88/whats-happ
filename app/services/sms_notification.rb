class SMSNotification < Struct.new(:phone_number, :body)
  ACCOUNT_SID = ENV.fetch('TWILIO_ACCOUNT_SID').freeze
  AUTH_TOKEN = ENV.fetch('TWILIO_AUTH_TOKEN').freeze
  FROM_NUMBER = ENV.fetch('TWILIO_FROM_NUMBER').freeze

  def call
    client.account.messages.create(from: FROM_NUMBER, to: phone_number, body: body)
  rescue Twilio::REST::RequestError => e
    handle_error(e)
  end

  def client
    @client ||= Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
  end

  private

  def handle_error(error)
    log_message = if /blacklist/i === e.message
      "BLACKLIST-FAIL:#{phone_number}"
    else
      "TWILIO-FAIL:#{phone_number}"
    end

    Rails.logger.warning(log_message)
  end
end
