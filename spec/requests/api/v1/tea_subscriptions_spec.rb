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
      expect(json[:total_subscriptions]).to eq(2)
      expect(json[:data].first[:id]).to eq(@tea_sub1.id.to_s)
      expect(json[:data].first[:type]).to eq("tea_subscription")
      expect(json[:data].first[:attributes][:frequency]).to eq(@tea_sub1.frequency)
      expect(json[:data].first[:attributes][:status]).to eq(@tea_sub1.status)
      expect(json[:data].first[:attributes][:customer_name]).to eq("Koala Tea Control")
      expect(json[:data].first[:attributes][:tea_type]).to eq(@tea1.name)
    end

    it "can get a single subscription with more details" do
      get "/api/v1/tea_subscriptions/#{@tea_sub1.id}"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:data][:id]).to eq(@tea_sub1.id.to_s)
      expect(json[:data][:type]).to eq("tea_subscription")
      expect(json[:data][:attributes][:frequency]).to eq(@tea_sub1.frequency)
      expect(json[:data][:attributes][:status]).to eq(@tea_sub1.status)
      expect(json[:data][:attributes][:customer_details][:full_name]).to eq("Koala Tea Control")
      expect(json[:data][:attributes][:customer_details][:email]).to eq(@customer1.email)
      expect(json[:data][:attributes][:customer_details][:address]).to eq(@customer1.address)
      expect(json[:data][:attributes][:tea_details][:name]).to eq(@tea1.name)
      expect(json[:data][:attributes][:tea_details][:description]).to eq(@tea1.description)
      expect(json[:data][:attributes][:tea_details][:brew_time]).to eq(@tea1.brew_time)
      expect(json[:data][:attributes][:tea_details][:temperature]).to eq(@tea1.temperature)
    end
  end
end