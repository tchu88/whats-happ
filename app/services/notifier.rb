class Notifier
  include Enumerable

  def self.call(events)
    events.each do |event|
      new(event).call
    end
  end

  def initialize(event)
    @event = event
  end

  def each(&block)
    subscriptions.find_each(&block)
  end

  def call
    each do |subscription|
      notify(subscription, @event)
    end
  end

  # TODO: use polymorphism to dispatch notication type by subscription
  def notify(subscription, event)
    send_message(subscription.phone, event.message)
  end

  def send_message(phone, body)
    SMSNotification.new(phone, body).call
  end

  def subscriptions(&block)
    Subscription.contains(latitude: @event.latitude, longitude: @event.longitude)
  end
end
