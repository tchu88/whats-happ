task update_streams: :environment do
  Publisher.find_each do |publisher|
    StreamUpdate.new(publisher).call
  end
end
