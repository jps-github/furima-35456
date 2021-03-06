FactoryBot.define do
  factory :item do
    name               { Faker::Games::Pokemon.name }
    description        { Faker::Lorem.sentence }
    category_id        { Faker::Number.between(from: 1, to: 10) }
    condition_id       { Faker::Number.between(from: 1, to: 6) }
    delivery_charge_id { Faker::Number.between(from: 1, to: 2) }
    prefecture_id      { Faker::Number.between(from: 1, to: 47) }
    delivery_day_id    { Faker::Number.between(from: 1, to: 3) }
    price              { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user
    after(:build) do |item|
      item.images.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.jpeg')
    end
  end
end
