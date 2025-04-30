require "rails_helper"

RSpec.describe TeaSubscription, type: :model do
  describe "relationships" do
    it { should belong_to :customer }
    it { should belong_to :tea }
    it { should define_enum_for(:status).with_values(active: 0, inactive: 1) }
  end

  describe "tsvector scope" do
    before(:each) do
      @customer1 = create(:customer, first_name: "Koala", last_name: "Tea Control" )
      @customer2 = create(:customer, first_name: "Cutie", last_name: "Patootie")
      @tea1 = create(:tea, name: "Fireside Vanilla")
      @tea2 = create(:tea, name: "Tension Tamer")
  
      @tea_sub1 = create(:tea_subscription, customer: @customer1, tea: @tea1, status: "active", frequency: "monthly")
      @tea_sub2 = create(:tea_subscription, customer: @customer2, tea: @tea2, status: "active", frequency: "daily")
      @tea_sub3 = create(:tea_subscription, customer: @customer1, tea: @tea2, status: "inactive", frequency: "daily")
    end

    it "returns a grouping of matching statuses" do
      expect(TeaSubscription.search("active")).to include(@tea_sub1, @tea_sub2)
    end

    it "returns a grouping of matching frequencies" do
      expect(TeaSubscription.search("daily")).to include(@tea_sub2, @tea_sub3)
    end
  end
end