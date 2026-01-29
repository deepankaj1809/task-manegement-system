# spec/requests/login_spec.rb
require 'rails_helper'

RSpec.describe "User Login API", type: :request do
  before do
    post "/signup", params: {
      email: "user@example.com",
      password: "password"
    }
  end

  it "logs in user and returns jwt token" do
    post "/login", params: {
      email: "user@example.com",
      password: "password"
    }

    expect(response.status).to eq(200)

    body = JSON.parse(response.body)
    expect(body).to have_key("token")

    decoded = JWT.decode(
      body["token"],
      Rails.application.secret_key_base,
      true,
      algorithm: "HS256"
    )

    expect(decoded.first).to have_key("user_id")
  end

  it "returns unauthorized for wrong password" do
    post "/login", params: {
      email: "user@example.com",
      password: "wrong-password"
    }

    expect(response.status).to eq(401)
  end
end
