require 'rails_helper'

RSpec.describe User, type: :model do

  describe "relationships" do
    it { should validate_presence_of(:username)}
    it { should validate_presence_of(:role)}
    it { should validate_presence_of(:email)}
    it { should validate_presence_of(:cellphone)}
    it { should have_secure_password}
    it { should validate_uniqueness_of(:username).ignoring_case_sensitivity}
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity}
    it { should respond_to(:folders)}
    it { should respond_to(:shares)}
    it { should respond_to(:root)}
  end

  describe "model methods" do
    context "#root_folder" do
      it "has a root folder" do
        user = create(:user)
        expect(user.root_folder.name).to eq("root")
      end
    end

    context "#new_folder" do
      it "creates a new folder with appropriate root" do
        user = create(:user)
        music = user.new_folder("Music")
        weezer = user.new_folder("Weezer", music)

        expect(weezer.parent).to eq(music)
      end
    end

    context "#share_folder" do
      it "shares folder with appropriate users" do
        user1, user2, user3 = create_list(:user, 3)
        music = user1.new_folder("Music")
        user1.share_folder(user2, music)

        expect(music.authorized_viewers).to include(user2)
        expect(music.authorized_viewers).to_not include(user3)
      end
    end

    context "#is_shared_with_me?" do
      it "returns true if authorized viewer of folder" do
        user1, user2, user3 = create_list(:user, 3)
        music = user1.new_folder("Music")
        user1.share_folder(user2, music)

        expect(user2.is_shared_with_me?(music)).to eq(true)
        expect(user3.is_shared_with_me?(music)).to eq(nil)
      end
    end

    context "allowed_to_see?" do
      it "retruns true if owner, public, or authorized_viewer" do
        user1, user2, user3 = create_list(:user, 3)
        music = user1.new_folder("Music")
        dnc_data = user1.new_folder("DNC SECRETS")
        dnc_data.public_folder!
        user1.share_folder(user2, music)

        expect(user2.allowed_to_see?(music)).to eq(true)
        expect(user3.is_shared_with_me?(music)).to eq(nil)
        expect(user3.allowed_to_see?(dnc_data)).to eq(true)
        expect(user2.allowed_to_see?(dnc_data)).to eq(true)
        expect(user3.allowed_to_see?(user3.root_folder)).to eq(true)
        expect(user3.allowed_to_see?(user2.root_folder)).to eq(nil)
      end
    end
  end
end
