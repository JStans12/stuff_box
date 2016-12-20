require 'rails_helper'

describe "a user can see a list of folders shared with them" do
  context "a logged in user visits the root" do
    it "they see their shared folders" do
      user1, user2, user3, user4 = create_list(:user, 4)
      music = user1.new_folder("music")
      weezer = user1.new_folder("weezer", music)
      pics = user2.new_folder("pics")

      user1.share_folder(user3, weezer)
      user2.share_folder(user3, pics)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user3)
      allow_any_instance_of(ApplicationController).to receive(:current_folder).and_return(user3.root_folder)

      visit '/'

      within('.shared-folders') do
        expect(page).to have_content(user1.username)
        expect(page).to have_content(user2.username)
        expect(page).to have_content(pics.name)
        expect(page).to have_content(weezer.name)
        expect(page).to_not have_content(user4.username)
        expect(page).to_not have_content(music.name)
      end

    end
  end
end
