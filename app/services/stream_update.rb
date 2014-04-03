require 'set'

class StreamUpdate < Struct.new(:publisher)
  attr_accessor :errors

  def import
    events.map do |attributes|
      event = find_or_initialize(attributes)

      # try to save unless the record is a duplicate
      if event.new_record?
        event.save
        event.errors.full_messages.each { |msg| errors << msg }
      end

      event
    end
  end

  def find_or_initialize(attributes)
    find(attributes) || Event.new(attributes)
  end

  # return the record if it exists, nil otherwise
  def find(attributes)
    Event.where(message: attributes['message']).first
  end

  def events
    @events ||= response['events']
  end

  def response
    @response ||= connection.get(publisher.url).body
  end

  def connection
    @connection ||= Faraday.new(url: publisher.url) do |conn|
      conn.response :json
      conn.adapter Faraday.default_adapter
    end
  end

  def errors
    @errors ||= Set.new
  end
end
