require 'rails_helper'

RSpec.describe AuthyService, type: :model do
	context 'Class method' do
		it 'send verification method instantiates a instance method of send verification code response' do
			VCR.use_cassette("class_send_verification") do
				cellphone = ENV['tester_cell_phone']
				expect(AuthyService).to receive_message_chain(:new, :send_verification_code_response)

				response = AuthyService.send_verification_code(cellphone)
			end
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
	end
end
