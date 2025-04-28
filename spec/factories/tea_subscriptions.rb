FactoryBot.define do
  factory :tea_subscription do
    customer
    tea
    frequency { ["daily", "weekly", "bi-weekly", "monthly"].sample }
    status{ [:active, :inactive].sample }
  end
end