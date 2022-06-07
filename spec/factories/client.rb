FactoryBot.define do

  factory :client do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {"123123123"}
  end
end