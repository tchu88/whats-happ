class StreamUpdate < Struct.new(:publisher, :notifier)
  def import
    body['events'].lazy.
      reject { |attributes| Event.exists?(message: attributes['message']) }.
      map { |attributes| Event.new(attributes) }.
      select { |event| event.save }.
      force
  end

  private

  def body
    @body ||= connection.get(publisher.url).body
  end

  def connection
    @connection ||= Faraday.new(url: publisher.url) do |conn|
      conn.response :json
      conn.adapter Faraday.default_adapter
    end
  end
end
