class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_or_create_new_user(user_params)
    if user.save
      response = AuthyService.send_verification_code(user.cellphone)
      session[:user_id] = user.id
      redirect_to verify_phone_path
    else
      flash.now[:danger] = "There was an error with your request"
      render :new
    end
  end

  def verify_phone
  end

  def verify_user
    message = AuthyService.check_verification_code(current_user, params[:verification_code])
    if message == "Verification code is correct."
      current_user.confirmed!
      flash[:success] = "Welcome to Stuff Box #{current_user.username.titleize}"
      redirect_to root_path
    else
      flash.now[:danger] = "Please enter your validation code again, or log in to request another code."
      render :verify_phone
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "You are logged out"
    redirect_to root_path
  end

  private

    def user_params
      params.permit(:username, :email, :cellphone, :password, :password_confirmation)
    end
end
