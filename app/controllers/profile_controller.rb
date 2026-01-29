class ProfileController < ApplicationController
  def show
    render json: { email: current_user.email }
  end
end
