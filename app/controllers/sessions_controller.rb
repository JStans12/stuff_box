class SessionsController < ApplicationController

  def new

  end

  def register_authy
    Faraday.post("https://api.authy.com/protected/json/phones/verification/start?api_key=#{ENV['authy_token']}&via=sms&phone_number=#{params[:cellphone]}&country_code=1")
    session[:cellphone] = params[:cellphone]
    redirect_to verify_phone_path
  end

  def verify_phone
  end

  def create
    response = Faraday.get("https://api.authy.com/protected/json/phones/verification/check?api_key=#{ENV['authy_token']}&country_code=1&phone_number=#{session[:cellphone]}&verification_code=#{params[:verification_code]}")
    byebug
  end
end
