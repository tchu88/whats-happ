class Notifier < Struct.new(:event)
  def self.call(events)
    events.each do |event|
      new(event).call
    end
  end

  def call
    subscriptions.each do |subscription|
      send_message(subscription.phone, event.message)
    end
  end

  def send_message(phone, body)
  end

  def subscriptions
    Subscription.contains(latitude: event.latitude, longitude: event.longitude)
  end
end
