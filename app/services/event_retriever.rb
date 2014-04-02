class EventRetriever < Struct.new(:publisher)
  def import
    Event.create!(response['notifications'])
  end

  def response
    connection.get(publisher.url).body
  end

  def connection
    @connection ||= Faraday.new(url: publisher.url) do |conn|
      conn.response :json
      conn.adapter Faraday.default_adapter
    end
  end
end
