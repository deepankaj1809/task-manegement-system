require 'rails_helper'
RSpec.describe "Sign Up API", type: :request do
  it "creates a user and returns a token" do
    post "/signup", params: {
      email: "user@example.com",
      password: "password"
    }
  
    expect(response.status).to eq(201)
    expect(JSON.parse(response.body)).to have_key("token")
  end
end
