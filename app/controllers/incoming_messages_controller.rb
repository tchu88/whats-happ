class IncomingMessagesController < ApplicationController
  FILTER_WORDS = %w(CANCEL QUIT STOP UNSUBSCRIBE)
  FILTER_WORD_REGEXP = Regexp.union(FILTER_WORDS.map{|w| /^#{w}/ })

  skip_before_filter :verify_authenticity_token
  http_basic_authenticate_with name: ENV.fetch('TWILIO_MESSAGES_NAME'),
                               password: ENV.fetch('TWILIO_MESSAGES_PASSWORD')

  def create
    process_unsubscribe(params)
    head :ok    
  end

  private

  def process_unsubscribe(params)
    if FILTER_WORD_REGEXP === params['Body']
      Subscription.unsubscribe_number(params['From'])
    end
  end
end
