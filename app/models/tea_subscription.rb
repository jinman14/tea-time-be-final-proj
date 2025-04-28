class TeaSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  enum status: { active: 0, inactive: 1 }

  FREQUENCIES = ["daily", "weekly", "bi-weekly", "monthly"]

  validates :frequency, inclusion: { in: FREQUENCIES}
end