require 'rails_helper'

describe 'An admin visits the admin dashboard page' do
  before(:each) do
    @admin = User.create!(username: "admin", password: "admin", password_confirmation: "admin", email: "admin", cellphone: "3333333333", role: "admin")
    @john = User.create!(username: "John Elway", password: "je", password_confirmation: "je", email: "john@example.com", cellphone: "3033033333")
    @taylor = User.create!(username: "Taylor Swift", password: "ts", password_confirmation: "ts", email: "ts@example.com", cellphone: "3034567891")
    @barack = User.create!(username: "Barack Obama", password: "bo", password_confirmation: "bo", email: "bo@example.com", cellphone: "3035284637")
    @donny = User.create!(username: "Donald Trump", password: "dt", password_confirmation: "dt", email: "dt@example.com", cellphone: "4639398844")
    @von = User.create!(username: "Von Miller", password: "vm", password_confirmation: "vm", email: "vm@example.com", cellphone: "3039362718")
    @albert = User.create!(username: "Albert Einstein", password: "ae", password_confirmation: "ae", email: "ae@example.com", cellphone: "4159395611")

    @admin.confirmed!
    @john.confirmed!
    @taylor.confirmed!
    @barack.confirmed!
    @donny.confirmed!
    @von.confirmed!
    @albert.confirmed!

    @john.new_folder("football plays")
    @john.new_folder("cheerleader phone numbers")

    music = @taylor.new_folder("music")
    songs = @taylor.new_folder("songs", music)
    @taylor.new_folder("secret songs about boys", music)
    @taylor.share_folder(@john, songs)

    dnc_data = @barack.new_folder("dnc data")
    @barack.new_folder("classified")
    @barack.share_folder(@john, dnc_data)

    tweets = @donny.new_folder("classic tweets")
    @donny.share_folder(@taylor, tweets)
  end

  context "An admin can click Edit User" do
    it "and update a user's name" do
      visit "/login"

      within('#login') do
        fill_in "Username", with: @admin.username
        fill_in "Password", with: @admin.password
        click_button "Log In"
      end

    expect(User.find_by(username: "John Elway").shares.count).to eq(2)
    expect(User.find_by(username: "John Elway").folders.count).to eq(3)
    find('tr', text: 'john@example.com').click_on("Edit User")

    fill_in "user_username", with: "Johnny Elway"
    click_on "Update Account"

    expect(page).to have_content("Johnny Elway")
    expect(page).not_to have_content("John Elway")
    end
  end

  context "An admin can click Delete" do
    it "and delete a user and all their shares and folders" do
      visit "/login"

      within('#login') do
        fill_in "Username", with: @admin.username
        fill_in "Password", with: @admin.password
        click_button "Log In"
      end

    expect(User.find_by(username: "John Elway").folders.count).to eq(3)
    expect(User.find_by(username: "John Elway").shares.count).to eq(2)
    expect(User.count).to eq(7)
    expect(Folder.count).to eq(15)
    expect(Share.count).to eq(3)

    find('tr', text: 'john@example.com').click_button("Delete")

    expect(page).to have_content("Taylor Swift")
    expect(page).not_to have_content("John Elway")
    expect(User.count).to eq(6)
    expect(Folder.count).to eq(12)
    expect(Share.count).to eq(1)

    end
  end

end
