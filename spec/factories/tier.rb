FactoryBot.define do

  factory :tier do
    name { ["Standard", "Gold", "Platinum"].sample }
    priority { Faker::Number.between(from: 1, to: 3) }
  end
end