require "rails_helper"

RSpec.describe Tea, type: :model do
  describe "relationships" do
    it { should have_many :tea_subscriptions }
    it { should have_many(:customers).through(:tea_subscriptions) }
  end
end