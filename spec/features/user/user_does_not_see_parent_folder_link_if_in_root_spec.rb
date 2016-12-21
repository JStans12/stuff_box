require 'rails_helper'

describe "a logged in user views their files on dashboard" do
  context "while in their root folder" do
    it "the parent folder link is not visible" do
      user1, user2 = create_list(:user, 2)
      music = user1.new_folder("Music")
      weezer = user1.new_folder("Weezer", music)
      user1.share_folder(user2, music)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
      allow_any_instance_of(ApplicationController).to receive(:current_folder).and_return(user1.root_folder)

      visit '/'

      expect(page).not_to have_content("Foghghgdeleted")
    end
  end
end
