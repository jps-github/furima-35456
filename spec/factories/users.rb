FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { "aaa111" }
    password_confirmation { password }
    last_name             { "田中" }
    first_name            { "太郎" }
    last_name_katakana    { "タナカ" }
    first_name_katakana   { "タロウ" }
    birthday              { Faker::Date.in_date_period }
  end
end
