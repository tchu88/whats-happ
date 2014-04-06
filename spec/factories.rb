FactoryGirl.define do
  factory :notification do
  end

  factory :subscription do
    phone { Faker::PhoneNumber.short_phone_number }
    radius { (500..5000).to_a.sample }
    longitude { Faker::Geolocation.lng }
    latitude { Faker::Geolocation.lat }
    format { Subscription::FORMATS.sample }
  end

  factory :event do
    message { Faker::Lorem.sentence }
    longitude { Faker::Geolocation.lng }
    latitude { Faker::Geolocation.lat }
  end

  factory :publisher do
    sequence(:title) { |n| "title-#{n}" }
    sequence(:url) { |n| "https://publisher-#{n}.com/events.json" }
  end
end
