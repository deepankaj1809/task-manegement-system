# spec/requests/profile_spec.rb
require 'rails_helper'

RSpec.describe "Protected Profile API", type: :request do
  it "returns unauthorized without token" do
    get "/profile"
    expect(response.status).to eq(401)
  end

  it "returns user data with valid token" do
    post "/signup", params: {
      email: "user@example.com",
      password: "password"
    }

    token = JSON.parse(response.body)["token"]

    get "/profile", headers: {
      "Authorization" => "Bearer #{token}"
    }

    expect(response.status).to eq(200)
    body = JSON.parse(response.body)
    expect(body["email"]).to eq("user@example.com")
  end
end
