require 'rails_helper'

RSpec.describe "User Signup API", type: :request do
  it "creates a user and returns a valid jwt token" do
    post "/signup", params: {
      email: "user@example.com",
      password: "password"
    }

    expect(response.status).to eq(201)

    body = JSON.parse(response.body)
    expect(body).to have_key("token")

    token = body["token"]

    decoded = JWT.decode(
      token,
      Rails.application.secret_key_base,
      true,
      algorithm: "HS256"
    )

    expect(decoded.first).to have_key("user_id")
  end
end
