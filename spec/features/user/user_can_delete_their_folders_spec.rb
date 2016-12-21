require 'rails_helper'

describe "a logged in user views their files on dashboard" do
  context "they click delete on a file" do
    it "that file and it's children and shares no longer appear on the page or in the database" do
      user1, user2 = create_list(:user, 2)
      music = user1.new_folder("Music")
      weezer = user1.new_folder("Weezer", music)
      user1.share_folder(user2, music)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
      allow_any_instance_of(ApplicationController).to receive(:current_folder).and_return(user1.root_folder)

      visit '/'
      click_on 'Delete'

      within(".alert-success") do
        expect(page).to have_content("Folder is deleted")
      end

      expect(user1.folders.count).to eq(1)
      expect(Share.count).to eq(0)
    end
  end
end
