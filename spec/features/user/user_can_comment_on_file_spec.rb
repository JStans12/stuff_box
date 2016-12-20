require "rails_helper"

context "a user can have comment on a file" do
  describe "a user can comment on a file" do
    it "can leave a comment on a file page" do
      user = User.create(username: "Madonna", password: "m", password_confirmation: "m", email: 'm@m.com', cellphone: '3038857241')
      upload = Upload.create(url: "https://s3-us-west-1.amazonaws.com/stuff-box/Retest.png", name: "Retest", folder_id: user.root_folder.id )
      comment = Comment.create(content: Faker::Lorem.sentence, user: user, upload: upload )

      user.confirmed!
      visit '/login'


      within('#login') do
        fill_in "Username", with: user.username
        fill_in "Password", with: user.password
        click_button "Log In"
      end

      click_on "Comment"


      expect(page).to have_content(upload.name)
      expect(page).to have_content(comment.content)
    end
  end
end
