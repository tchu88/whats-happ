FactoryGirl.define do
  factory :subscription do
    phone { Faker::PhoneNumber.phone_number }
    radius { (500..5000).to_a.sample }
    longitude { Faker::Geolocation.lng }
    latitude { Faker::Geolocation.lat }
  end

  factory :event do
    message { Faker::Lorem.sentence }
    longitude { Faker::Geolocation.lng }
    latitude { Faker::Geolocation.lat }
  end

  factory :publisher do
    sequence(:title) { |n| "title-#{n}" }
    sequence(:url) { Faker::Internet.uri(%w(http https).sample) }
  end
end
