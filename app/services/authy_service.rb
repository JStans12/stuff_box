class AuthyService

	def initialize
		@conn = Faraday.new(:url => 'https://api.authy.com')
		@authy_params = { api_key: ENV['authy_token'], country_code: '1' }
	end

  def self.send_verification_code(cellphone)
  	new.send_verification_code_response(cellphone)
  end

	def send_verification_code_response(cellphone)
		conn.post do |req|
		  req.url '/protected/json/phones/verification/start'
		  req.params = { phone_number: cellphone, via: 'sms'}.merge(authy_params)
		end
	end

  def self.check_verification_code(user, verification_code)
  	response = new.check_verification_code_response(user, verification_code)
  	JSON.parse(response.body, symbolize_names: true)[:message]
  end

  def check_verification_code_response(user, verification_code)
  	conn.get do |req|
		  req.url '/protected/json/phones/verification/check'
		  req.params = { verification_code: verification_code, phone_number: user.cellphone }.merge(authy_params)
		end
  end

  private
  	attr_reader :conn, :authy_params
end
