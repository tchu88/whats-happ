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
  # TODO: replace hardcoded format for notification (subscription.format probably)
  # FYI: Notifier class is doing too much
  def notify(subscription, event)
    record = Notification.create(subscription: subscription, event: event, format: 'sms')
    send_message(record, subscription.phone, event.message)
  end

  def send_message(record, phone, body)
    SMSNotification.new(phone, body).call
    record.update(succeeded_at: Time.now)
  end

  def subscriptions(&block)
    Subscription.active.contains(latitude: @event.latitude, longitude: @event.longitude)
  end
end
