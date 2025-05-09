require "rails_helper" 

RSpec.describe "TeaSubscriptions", type: :request do
  before(:each) do
    @customer1 = create(:customer, first_name: "Koala", last_name: "Tea Control")
    @customer2 = create(:customer, first_name: "Cutie", last_name: "Patootie")
    @tea1 = create(:tea, name: "Fireside Vanilla")
    @tea2 = create(:tea, name: "Tension Tamer")

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

    it "can search subscriptions with tsvector by customer name" do
      get "/api/v1/tea_subscriptions", params: { query: "Koala Tea Control" }
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:data].first[:id]).to eq(@tea_sub1.id.to_s)
    end

    it "can search by tea" do
      get "/api/v1/tea_subscriptions", params: { query: "Tension Tamer" }
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:total_subscriptions]).to eq(1)
      expect(json[:data].first[:id]).to eq(@tea_sub2.id.to_s)
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

    it "will return an error if the id does not exist" do
      get "/api/v1/tea_subscriptions/banana"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:not_found)
      expect(json[:error]).to include("Couldn't find TeaSubscription with 'id'")
    end
  end

  describe "POST" do
    it "can create and display a new subscription" do
      new_subscription_params = {
        tea_subscription: {
          "customer_id": @customer2.id,
          "tea_id": @tea1.id,
          "frequency": "weekly",
          "status": "active"
        }
      }

      headers = { "CONTENT_TYPE" => "application/json" }

      post "/api/v1/tea_subscriptions", params: new_subscription_params.to_json, headers: headers

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:id]).to be_present
      expect(json[:data][:type]).to eq("tea_subscription")
      expect(json[:data][:attributes][:frequency]).to eq("weekly")
      expect(json[:data][:attributes][:status]).to eq("active")

      expect(json[:data][:attributes][:customer_details][:full_name]).to eq("Cutie Patootie")
      expect(json[:data][:attributes][:customer_details][:email]).to eq(@customer2.email)
      expect(json[:data][:attributes][:customer_details][:address]).to eq(@customer2.address)

      expect(json[:data][:attributes][:tea_details][:name]).to eq(@tea1.name)
      expect(json[:data][:attributes][:tea_details][:description]).to eq(@tea1.description)
      expect(json[:data][:attributes][:tea_details][:brew_time]).to eq(@tea1.brew_time)
      expect(json[:data][:attributes][:tea_details][:temperature]).to eq(@tea1.temperature)
    end

    it "catches if a bad post call is made" do
      bad_params = {
        tea_subscription: {
          customer_id: @customer2.id,
          frequency: "weekly",
          status: "active"
        }
      }
      
      headers = { "CONTENT_TYPE" => "application/json" }
      
      post "/api/v1/tea_subscriptions", params: bad_params.to_json, headers: headers
      
      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(json[:error]).to be_present
    end
  end

  describe "PATCH" do
    it "can deactivate an existing subscription" do
      patch "/api/v1/tea_subscriptions/#{@tea_sub2.id}", params: { tea_subscription: { status: "inactive" } }.to_json, headers: { "CONTENT_TYPE" => "application/json" }

      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to have_http_status(:ok)
      expect(json[:data][:id]).to eq(@tea_sub2.id.to_s)
      expect(json[:data][:attributes][:status]).to eq("inactive")
    end

    it "can activate an existing subscription" do
      tea_sub3 = create(:tea_subscription, customer: @customer1, tea: @tea2, status: :inactive)

      patch "/api/v1/tea_subscriptions/#{tea_sub3.id}", params: { tea_subscription: { status: "active" } }.to_json, headers: { "CONTENT_TYPE" => "application/json" }

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:data][:id]).to eq(tea_sub3.id.to_s)
      expect(json[:data][:attributes][:status]).to eq("active")
    end

    it "returns an error if given invalid status" do
      patch "/api/v1/tea_subscriptions/#{@tea_sub1.id}", params: { tea_subscription: { status: "expired" } }.to_json, headers: { "CONTENT_TYPE" => "application/json" }
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to have_http_status(:internal_server_error)
      expect(json[:error]).to include("is not a valid status")
    end
  end
end