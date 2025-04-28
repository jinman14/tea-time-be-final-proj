require "rails_helper" 

RSpec.describe "TeaSubscriptions", type: :request do
  before(:each) do
    @customer1 = create(:customer)
    @customer2 = create(:customer)
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
      expect(json[:data].first[:attributes[:status]]).to eq(@tea_sub1.status)
      expect(json[:data].first[:attributes][:customer][:first_name]).to eq(@customer1.first_name)
      expect(json[:data].first[:attributes][:customer][:last_name]).to eq(@customer1.last_name)
      expect(json[:data].first[:attributes][:tea][:name]).to eq(@tea1.name)
      expect(json[:data].first[:attributes][:tea][:brew_time]).to eq(@tea1.brew_time)
    end
  end
end