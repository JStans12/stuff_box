require 'rubygems'  # This line not needed for ruby > 1.8
require 'twilio-ruby'

# You will need your Account Sid and a API Key Sid and Secret
# to generate an Access Token for your SDK endpoint to connect to Twilio.
account_sid = 'AC5a2c984ed70f1755b45daebb36035fd8'
apikey_sid = SID
apikey_secret = SECRET

token = Twilio::Util::AccessToken.new apikey_sid, account_sid, apikey_secret
token.add_endpoint_grant ENDPOINT_NAME
token.enable_nts
puts token.to_jwt