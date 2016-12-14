class AuthyService

  def self.send_verification_code(cellphone)
    Faraday.post("https://api.authy.com/protected/json/phones/verification/start?api_key=#{ENV['authy_token']}&via=sms&phone_number=#{cellphone}&country_code=1")
  end

  def self.check_verification_code(user, verification_code)
    response = Faraday.get("https://api.authy.com/protected/json/phones/verification/check?api_key=#{ENV['authy_token']}&country_code=1&phone_number=#{user.cellphone}&verification_code=#{verification_code}")
    JSON.parse(response.body)["message"]
  end

end
