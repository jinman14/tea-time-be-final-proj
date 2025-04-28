class TeaSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  enum status: { active: 0, inactive: 1 }

  FREQUENCIES = ["daily", "weekly", "bi-weekly", "monthly"]

  validates :frequency, inclusion: { in: FREQUENCIES }

  before_save :update_search_vector

  scope :search, ->(query) {
    sanitized = ActiveRecord::Base.connection.quote(query)
    where("search_vector @@ plainto_tsquery('english', #{sanitized})")
  }

  private

  def update_search_vector
    combined_text = [
      status,
      frequency,
      customer&.first_name,
      customer&.last_name,
      tea&.name,
      tea&.description
    ].compact.join(' ')

    result = ActiveRecord::Base.connection.execute(
      "SELECT to_tsvector('english', #{ActiveRecord::Base.connection.quote(combined_text)})"
    ).first

    self.search_vector = result['to_tsvector']
  end
end