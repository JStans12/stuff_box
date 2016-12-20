require 'rails_helper'

describe "a logged in user can view a list of public folders" do
  context "a user clicks on public folders" do
    it "they are redirected and see a list of public folders" do
      user1, user2 = create_list(:user, 2)
      private_music = user1.new_folder("Private Music")
      public_music = user1.new_folder("Public Music")
      public_music.public_folder!

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
      allow_any_instance_of(ApplicationController).to receive(:current_folder).and_return(user2.root_folder)

      visit '/'
      click_on 'Public Folders'

      expect(page).to have_content("Public Music")
      expect(page).to_not have_content("Private Music")
    end
  end
end
