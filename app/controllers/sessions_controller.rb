class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.new(user_params)
    if user.save
      response = AuthyService.send_verification_code(user.cellphone)
      session[:user_id] = user.id
      redirect_to verify_phone_path
    else
      #raise some error
    end
  end

  def verify_phone
  end

  def verify_user
    message = AuthyService.check_verification_code(current_user, params[:verification_code])
    if message == "Verification code is correct."
      current_user.confirmed!
      redirect_to root_path
    else
      #raise some error
    end
  end

  private

    def user_params
      params.permit(:username, :email, :cellphone, :password, :password_confirmation)
    end
end
