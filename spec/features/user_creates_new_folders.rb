require 'rails_helper'

RSpec.feature "User logs in" do
  context "they can create folders" do
    it "can see the folder they created"
    create(:user)
    visit "/login"
    save_and_open_page
    f = create(:folder)

    byebug
    expect(f).to be_a(:folder)
  end
end
