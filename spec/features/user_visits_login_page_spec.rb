require "rails_helper"

RSpec.feature "User visits login page" do
  context "they can't log in" do
    it "with a bad username" do
      user = User.create(username: "John Elway", password: "je", password_confirmation: "je", email: 'je@je.com', cellphone: '1234561234')

      visit '/login'
      within('#login') do
        fill_in "Username", with: "sandwich"
        fill_in "Password", with: user.password
        click_button "Log In"
      end

      expect(page).to have_content('Unable to login')
    end
  end

  context "they can't log in" do
    it "with a bad password" do
      user = User.create(username: "John Elway", password: "je", password_confirmation: "je", email: 'je@je.com', cellphone: '1234561234')

      visit '/login'
      within('#login') do
        fill_in "Username", with: user.username
        fill_in "Password", with: "badpassword"
        click_button "Log In"
      end

      expect(page).to have_content('Unable to login')
    end
  end

  context "they can log in" do
    it "with a valid username and password" do
      user = User.create(username: "John Elway", password: "je", password_confirmation: "je", email: 'je@je.com', cellphone: '1234561234', status: 1)
      user.confirmed!
      visit '/login'

      within('#login') do
        fill_in "Username", with: user.username
        fill_in "Password", with: user.password

        click_button "Log In"

      end
      expect(page).to have_content('Folders')
      expect(page).to have_content('Parent Folder')
      expect(page).to have_content('Root')
    end
  end

  context "they can't create a new user" do
    it "with a username that already exists" do
      user = User.create(username: "John Elway", password: "je", password_confirmation: "je", email: 'je@je.com', cellphone: '1234561234')

      visit '/login'

      within('#create-user') do
        fill_in "Username", with: "John Elway"
        fill_in "Email", with: "newpassword"
        fill_in "Cell Number", with: '3031234567'
        fill_in "Password", with: 'p'
        fill_in "Confirm Password", with: 'p'

        click_button "Create Account"
      end

      expect(page).to have_content('Unable to create account')
    end
  end


end
