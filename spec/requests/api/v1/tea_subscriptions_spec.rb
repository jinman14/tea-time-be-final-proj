require "rails_helper" 

RSpec.describe "TeaSubscriptions", type: :request do
  before(:each) do
    @customer1 = create(:customer, first_name: "Koala", last_name: "Tea Control")
    @customer2 = create(:customer, first_name: "Cutie", last_name: "Patootie")
    @tea1 = create(:tea)
    @tea2 = create(:tea)

    @tea_sub1 = create(:tea_subscription, customer: @customer1, tea: @tea1)
    @tea_sub2 = create(:tea_subscription, customer: @customer2, tea: @tea2)
  end
  describe "GET" do
    it "returns a list of all tea_subscriptions" do
      get "/api/v1/tea_subscriptions"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:data].length).to eq(2)
      expect(json[:data].first[:id]).to eq(@tea_sub1.id.to_s)
      expect(json[:data].first[:attributes][:frequency]).to eq(@tea_sub1.frequency)
      expect(json[:data].first[:attributes][:status]).to eq(@tea_sub1.status)
      expect(json[:data].first[:attributes][:customer_name]).to eq("Koala Tea Control")
      expect(json[:data].first[:attributes][:tea_type]).to eq(@tea1.name)
    end
  end
end