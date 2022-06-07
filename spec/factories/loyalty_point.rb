FactoryBot.define do

  factory :loyalty_point do
    points {Faker::Number.between(from: 50, to: 150)}
    customer { association(:customer) }
    transaction { association(:transaction) }
  end
end