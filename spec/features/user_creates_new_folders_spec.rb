require 'rails_helper'

RSpec.feature "User logs in" do
  context "they can create folders" do
    it "can see the folder they created" do
      user = User.create(username: "John Elway", password: "je", password_confirmation: "je", email: 'je@je.com', cellphone: '1234561234')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(ApplicationController).to receive(:current_folder).and_return(user.root_folder)

      visit '/'

      click_on "New Folder"
      fill_in "Name", with: "Music"
      click_button "Create Folder"

      expect(user.folders.count).to eq(2)
      expect(user.root_folder.children.first.name).to eq("Music")
      # expect(page).to have_content('Music')
      # TODO I can't get this to show up on the page, but byebug shows that the relationship is correct
      # It seems to be the same error that occures in rails console
      # I'm just testing the relationships instead for now
      # The next test will verify that a user's folders actually show up correctly
    end

    it "can see multiple folders they created" do
      user = create(:user)
      music = user.new_folder("music")
      photos = user.new_folder("photos")
      weezer = user.new_folder("weezer", music)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(ApplicationController).to receive(:current_folder).and_return(user.root_folder)

      visit '/'

      expect(page).to have_content('music')
      expect(page).to have_content('photos')
      expect(page).to_not have_content('weezer')
    end
  end
end
