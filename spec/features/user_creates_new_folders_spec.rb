require 'rails_helper'

RSpec.feature "User logs in" do
  context "they can create folders" do
    it "can see the folder they created" do
      user = User.create(username: "John Elway", password: "je", password_confirmation: "je", email: 'je@je.com', cellphone: '1234561234')

      visit '/login'

      within('#login') do
        fill_in "Username", with: user.username
        fill_in "Password", with: user.password
        click_button "Log In"
      end

      click_on "New Folder"
      fill_in "Name", with: "Music"
      click_button "Create Folder"

      expect(page).to have_content('Music')
      expect(page).to have_content('Parent Folder')
      expect(page).to have_content('Root')
      expect(page).to have_content('New Folder')
    end

    it "can see multiple folders they created" do
      user = User.create(username: "John Elway", password: "je", password_confirmation: "je", email: 'je@je.com', cellphone: '1234561234')

      visit '/login'

      within('#login') do
        fill_in "Username", with: user.username
        fill_in "Password", with: user.password
        click_button "Log In"
      end

      click_on "New Folder"
      fill_in "Name", with: "Music"
      click_button "Create Folder"

      click_on "New Folder"
      fill_in "Name", with: "Photos"
      click_button "Create Folder"

      click_on "New Folder"
      fill_in "Name", with: "Wedding Photos"
      click_button "Create Folder"

      click_on "New Folder"
      fill_in "Name", with: "Private Stuff"
      click_button "Create Folder"

      expect(page).to have_content('Music')
      expect(page).to have_content('Photos')
      expect(page).to have_content('Wedding Photos')
      expect(page).to have_content('Private Stuff')
      expect(page).to_not have_content('Ultra Secret')

    end
  end
end
