FactoryBot.define do

  factory :customer_reward do
    reward { association(:reward) }
    customer { association(:customer) }
  end
end