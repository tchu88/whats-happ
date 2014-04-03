class StreamUpdate < Struct.new(:publisher)
  def import
    current_events.lazy.
      map { |attributes| Event.new(attributes) }.
      select { |event| event.save }.
      force
  end

  def current_events
    @current_events ||= connection.get.body['events']
  end

  def connection
    @connection ||= Faraday.new(url: publisher.url) do |conn|
      conn.response :json
      conn.adapter Faraday.default_adapter
    end
  end
end
