require "rails_helper"

RSpec.feature "User visits login page" do
  context "they can't log in" do
    it "with a bad email" do
      user = User.create(username: "", password: "pass")

      visit '/login'
      within('#login') do
        fill_in "Username", with: user.username
        fill_in "Password", with: user.password
        click_button "Log In"
      end

      expect(page).to have_content('Unable to login')
    end
  end

  context "they can't log in" do
    it "with a bad password" do
      user = User.create(username: "John Elway", password: "BadPassword")

      visit '/login'
      within('#login') do
        fill_in "Username", with: user.username
        fill_in "Password", with: user.password
        click_button "Log In"
      end

      expect(page).to have_content('Unable to login')
    end
  end

  context "they can log in" do
    it "with a valid username and password" do
      user = User.create(username: "John Elway", password: "je", password_confirmation: "je", email: 'je@je.com', cellphone: '1234561234')

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
    it "with a password that already exists" do
      user = User.create(username: "John Elway", password: "je", password_confirmation: "je", email: 'je@je.com', cellphone: '1234561234')

      visit '/login'

      within('#login') do
        fill_in "Username", with: user.username
        fill_in "Password", with: user.password

        click_button "Log In"
      end

      click_on "Logout"
      click_on "Login"
      within('#create-user') do
        fill_in "Username", with: "John Elway"
        require "pry"; binding.pry
        fill_in "Email", with: "je@je.com"
        fill_in "Cell Number", with: '3031234567'
        fill_in "Password", with: 'p'
        fill_in "Confirm Password", with: 'p'

        click_button "Create Account"
      end

      expect(page).to have_content('Unable to login')
    end
  end


end
