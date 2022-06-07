FactoryBot.define do

  factory :customer_tier do
    tier { association(:tier) }
    customer { association(:customer) }
  end
end