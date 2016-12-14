class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.new(user_params)
    if user.save
      Faraday.post("https://api.authy.com/protected/json/phones/verification/start?api_key=#{ENV['authy_token']}&via=sms&phone_number=#{params[:cellphone]}&country_code=1")
      session[:user_id] = user.id
      redirect_to verify_phone_path
    else
      #raise some error
    end
  end

  def verify_phone
  end

  def verify_user
    response = Faraday.get("https://api.authy.com/protected/json/phones/verification/check?api_key=#{ENV['authy_token']}&country_code=1&phone_number=#{current_user.cellphone}&verification_code=#{params[:verification_code]}")
    message = JSON.parse(response.body)["message"]
    if message == "Verification code is correct."
      current_user.confirmed!
      redirect_to root_path
    end
  end

  private

    def user_params
      params.permit(:username, :email, :cellphone, :password, :password_confirmation)
    end
end
