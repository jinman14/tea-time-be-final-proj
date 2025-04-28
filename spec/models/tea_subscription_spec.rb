require "rails_helper"

RSpec.describe TeaSubscription, type: :model do
  describe "relationships" do
    it { should belong_to :customer }
    it { should belong_to :tea }
    it { should define_enum_for(:status).with_values(active: 0, inactive: 1) }
  end
end