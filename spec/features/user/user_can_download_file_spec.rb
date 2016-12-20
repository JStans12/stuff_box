require "rails_helper"

RSpec.feature "User downloads" do
  context "a user can download a file from their folder" do
    it "can download files" do
      user = User.create(username: "Madonna", password: "m", password_confirmation: "m", email: 'm@m.com', cellphone: '3038857241')
      upload = Upload.create(url: "https://s3-us-west-1.amazonaws.com/stuff-box/Retest.png", name: "Retest", folder_id: user.root_folder.id )

      user.confirmed!
      visit '/login'


      within('#login') do
        fill_in "Username", with: user.username
        fill_in "Password", with: user.password
        click_button "Log In"
      end

    expect(page).to have_content("Download")
    end
  end
  context "a user can delete a file from their folder" do
    it "can delete files" do
      user = User.create(username: "Madonna", password: "m", password_confirmation: "m", email: 'm@m.com', cellphone: '3038857241')
      upload = Upload.create(url: "https://s3-us-west-1.amazonaws.com/stuff-box/Retest.png", name: "Retest", folder_id: user.root_folder.id )

      user.confirmed!
      visit '/login'


      within('#login') do
        fill_in "Username", with: user.username
        fill_in "Password", with: user.password
        click_button "Log In"
      end

    expect(page).to have_content("Delete")
    end
  end
end
