require "rails_helper"

RSpec.feature "User downloads" do
  context "a user can download a file from their folder" do
    it "can download files" do
    # user = create(:user)

    #when a user logs in
    visit '/'
    click_link 'Login  |  Create Account'
    #they can see their files
    #they can click on download
    #the file downloads
    end
  end
end
