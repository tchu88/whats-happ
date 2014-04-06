class StreamUpdate < Struct.new(:publisher)
  REQUIRED_ATTRIBUTES = %w(message longitude latitude)

  class PermittedAttributes < ActionController::Parameters; end

  def call
    current_events.lazy.
      map(&method(:permit_attributes)).
      map(&method(:build_event)).
      select(&method(:save?)).
      force
  end

  def permit_attributes(attributes)
    PermittedAttributes.new(attributes).permit(REQUIRED_ATTRIBUTES)
  end

  def build_event(attributes)
    publisher.events.new(attributes)
  end

  def save?(event)
    event.save
  end

  # TODO: extract http stuff into a separate class
  def current_events
    response['events']
  end

  def response
    @response ||= connection.get.body
  end

  def connection
    @connection ||= Faraday.new(url: publisher.url) do |conn|
      conn.response :json
      conn.adapter Faraday.default_adapter
    end
  end
end
