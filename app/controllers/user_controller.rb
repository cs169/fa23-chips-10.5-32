# frozen_string_literal: true

class UserController < SessionController
  def profile
    @user = User.find_by(id: session[:current_user_id])

    if @user.nil?
      flash[:alert] = 'User not found. Please log in.'
      redirect_to login_path
    end
    # Other profile action logic here...
  end
end
