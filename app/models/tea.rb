class Tea < ApplicationRecord
  has_many :tea_subscriptions
  has_many :customers, through: :tea_subscriptions
end