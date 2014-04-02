class EventRetriever < Struct.new(:connection, :publisher)
  def import
    response = connection.get(publisher.url).body
    Event.create!(response['notifications'])
  end
end
