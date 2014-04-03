require 'set'

class EventRetriever < Struct.new(:publisher)
  attr_accessor :errors

  def import
    events.map do |attributes|
      event = Event.new(attributes)

      unless event.save
        event.errors.full_messages.each { |msg| errors << msg }
      end

      event
    end
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
