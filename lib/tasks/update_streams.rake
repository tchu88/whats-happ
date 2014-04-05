task update_streams: :environment do
  Publisher.find_each do |publisher|
    events = StreamUpdate.new(publisher).call
    Notifier.call(events)
  end
end
