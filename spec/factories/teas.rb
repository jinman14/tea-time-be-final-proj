FactoryBot.define do
  factory :tea do
    name { Faker::Tea.variety }
    description { Faker::Lorem.sentence }
    brew_time { "#{rand(3..5)} minutes" }
    temperature { rand(190..220) }
  end
end