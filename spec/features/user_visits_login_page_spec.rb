require "rails_helper"

RSpec.feature "User visits login page" do
  context "they can't log in" do
    it "with a bad email" do
      user = User.new(email: "brad@yahoo.com", password: "pass")

      visit '/login'
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      within(".form-horizontal") do
        click_on "Login"
      end
