require 'rails_helper'

describe "a user can shares a folder with another user" do
  context "they see a flash message confirming the share" do
    it "the shared with user sees the folder in their shared panel" do
      user1, user2 = create_list(:user, 2)
      music = user1.new_folder("Music")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
      allow_any_instance_of(ApplicationController).to receive(:current_folder).and_return(user1.root_folder)

      visit '/'
      click_on "Share"
      fill_in :username, with: user2.username

      allow_any_instance_of(ApplicationController).to receive(:current_folder).and_return(music)

      click_on "Share"

      expect(page).to have_content("You shared Music with #{user2.username}!")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
      allow_any_instance_of(ApplicationController).to receive(:current_folder).and_return(user2.root_folder)

      visit '/'

      expect(page).to have_content(user1.username)
      expect(page).to have_content("Music")
    end
  end
end
