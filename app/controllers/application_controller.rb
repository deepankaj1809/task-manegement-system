class ApplicationController < ActionController::API
  before_action :authenticate_request

  attr_reader :current_user

  private

  def authenticate_request
    header = request.headers["Authorization"]
    token = header.split(" ").last if header

    decoded = JsonWebToken.decode(token)
    @current_user = User.find(decoded.first["user_id"])
  rescue
    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end
