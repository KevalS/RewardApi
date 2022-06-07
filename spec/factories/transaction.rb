FactoryBot.define do

  factory :transaction do
    amount { Faker::Number.between(from: 50.0, to: 1000.0) }
    description { Faker::Lorem.words(number: rand(2..10)).join(' ') }
    country { Faker::Address.country_code }
    currency { "USD" }
    customer { association(:customer) }
  end
end