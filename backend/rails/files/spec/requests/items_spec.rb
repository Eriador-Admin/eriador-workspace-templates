require "rails_helper"

RSpec.describe "Api::V1::Items", type: :request do
  describe "GET /api/v1/items" do
    it "returns a list of items" do
      Item.create!(name: "Test Item")
      get "/api/v1/items"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe "POST /api/v1/items" do
    it "creates an item" do
      post "/api/v1/items", params: { item: { name: "New Item" } }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["name"]).to eq("New Item")
    end
  end
end
