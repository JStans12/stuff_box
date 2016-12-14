require 'rails_helper'

RSpec.describe AuthyService, type: :model do
	context 'Class method' do
		it 'send verification method instantiates a instance method of send verification code response' do
			cellphone = ENV['tester_cell_phone']
			expect(AuthyService).to receive_message_chain(:new, :send_verification_code_response)

			response = AuthyService.send_verification_code(cellphone)
		end

		it 'check verification instantiates a instance method of check verification code response' do
			user = create(:user)
			verification_code = 'xxx'
			expect(AuthyService).to receive_message_chain(:new, :check_verification_code_response, :body)

			response = AuthyService.check_verification_code(user, verification_code)

		end
	end

	context 'Instance method' do
		it 'send verification returns a successfull response' do
			VCR.use_cassette('send_verify_instance_method') do
				cellphone = ENV['tester_cell_phone']
				response = AuthyService.new.send_verification_code_response(cellphone)

				parsed_response = JSON.parse(response.body, symbolize_names: true)

				expect(response.status).to eq(200)
				expect(parsed_response[:success]).to eq(true)
				expect(parsed_response[:is_cellphone]).to eq(true)
			end
		end

		it 'check verification returns a successfull response' do
			VCR.use_cassette('check_verify_instance_method') do
				user = create(:user, cellphone: ENV['tester_cell_phone'])
				verification_code = ENV['verification_code']

				response = AuthyService.new.check_verification_code_response(user, verification_code)
				response_parsed = JSON.parse(response.body, symbolize_names: true)[:message]

				expect(response_parsed).to eq("Verification code is correct.")
			end
		end
	end
end
