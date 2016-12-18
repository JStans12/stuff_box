require 'rails_helper'

describe 'An admin visits the login page' do
  before(:each) do
    @admin = User.create(username: "Admin2", email: "admin2@admin.com", cellphone: 3038857241, password: "admin", password_confirmation: "admin", role: 1)
    @user = User.create(username: "DJ", email: "dj@dj.com", password: "dj", password_confirmation: "dj", cellphone: 3038857241)
    @admin.confirmed!
    @user.confirmed!
  end

  context "An admin can login" do
    it "visits the login page" do
      visit "/login"
      within('#login') do
        click_button "Log In"
        fill_in "username", with: @admin.username
        fill_in "email", with: @admin.email
        fill_in "password", with: @admin.password
        fill_in "password_confirmation", with: @admin.password
      end
      within('#login') do
        fill_in "Username", with: @admin.username
        fill_in "Password", with: @admin.password
        click_button "Log In"
      end
    end
  end
end
