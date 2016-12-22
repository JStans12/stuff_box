class SessionsController < ApplicationController

  def new
  end

  def login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password]) && user.admin?
      session[:user_id] = user.id
      session[:current_folder_id] = user.root
      redirect_to admin_dashboard_index_path
    elsif user && user.authenticate(params[:password])
      return continue_to_phone_verification(user) unless user.confirmed?
      session[:user_id] = user.id
      session[:current_folder_id] = user.root
      redirect_to root_path
    else
      # TODO should be able to call user.errors here and render specific errors
      flash.now[:danger] = "Unable to login"
      render :new
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      continue_to_phone_verification(user)
    else
      # TODO should be able to call user.errors here and render specific errors
      flash.now[:danger] = "Unable to create account"
      render :new
    end
  end

  def verify_phone
  end

  def verify_user
    message = AuthyService.check_verification_code(current_user, params[:verification_code])
    if message == "Verification code is correct."
      current_user.confirmed!
      flash[:success] = "Welcome to Stuff Box, #{current_user.username.titleize} your token is #{current_user.token}. Write that down if you wanna use our API."
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

    def continue_to_phone_verification(user)
      response = AuthyService.send_verification_code(user.cellphone)
      session[:user_id] = user.id
      session[:current_folder_id] = user.root
      redirect_to verify_phone_path
    end
end
