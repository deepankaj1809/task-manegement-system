class AuthController < ActionController::API
  def signup
    user = User.create!(
      email: params[:email],
      password: params[:password]
    )

    render json: { token: "dummy-token" }, status: :created
  end
end
