class AuthController < ActionController::API
  def signup
    user = User.create!(
      email: params[:email],
      password: params[:password]
    )

    token = JsonWebToken.encode(user_id: user.id)

    render json: { token: token }, status: :created
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end
end
