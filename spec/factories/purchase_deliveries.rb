FactoryBot.define do
  factory :purchase_delivery do
    post_code     { "123-4567" }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city          { "タナカ市" }
    address       { "タナカ1丁目2番地3号" }
    building_name { "タナカビル123階" }
    phone_number  { "08012345678" }
    association :user
    association :item
    token         { "sjdnvvvimfvninfisdnfiosmiosdm" }
  end
end
