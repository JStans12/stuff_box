require 'rails_helper'

describe "a user can't see private folders that aren't shared with them" do
  context "a logged in user visits the root" do
    it "they don't folders they shouldn't" do
      user1, user2 = create_list(:user, 2)
      folder = user2.root_folder.id
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit "/dashboard/#{folder}"

      expect(page).to have_content("404")
    end
  end
end
