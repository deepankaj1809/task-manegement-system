class AuthController < ActionController::API
  def signup
    user = User.create!(
      email: params[:email],
      password: params[:password]
    )

    token = JsonWebToken.encode(user_id: user.id)

    render json: { token: token }, status: :created
  end
end
