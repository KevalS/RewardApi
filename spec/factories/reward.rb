FactoryBot.define do

  factory :reward do
    name { ["Coffee Reward", "Birthday Coffee reward", "5% Cash Rebate Reward", "Movie Ticket Reward", "Airport Lounge access Reward"].sample }
    description { Faker::Lorem.words(number: rand(2..10)) }
  end
end