require 'rails_helper'

RSpec.describe Folder, type: :model do

  describe "relationships" do
    it { should respond_to(:shares)}
    it { should respond_to(:authorized_viewers)}
    it { should respond_to(:children)}
    it { should respond_to(:parent)}
  end

  describe "model methods" do
    context ".owner" do
      it "should return it's owner" do
        user = create(:user)
        music = user.new_folder("music")

        expect(music.owner).to eq(user)
      end
    end

    context ".owners" do
      it "retunrs all owners for a collection of folders" do
        user1, user2, user3 = create_list(:user, 3)
        folders = Folder.where.not(owner_id: user2.id)
        expect(folders.owners).to eq([user1, user3])
      end
    end

    context ".by_owner" do
      it "returns a hash with the user object pointing to their folders" do
        user1, user2 = create_list(:user, 2)
        music = user2.new_folder("Music")
        expect(Folder.by_owner).to eq({user1 => [user1.root_folder], user2 => [user2.root_folder, music]})
      end
    end

    context ".public" do
      it "returns all public folders from a collection" do
        user = create(:user)
        music = user.new_folder("Music")
        pics = user.new_folder("Pics")
        secrets = user.new_folder("Secrets")
        music.public_folder!
        pics.public_folder!

        expect(Folder.public).to eq([music, pics])
      end
    end

    context "#public?" do
      it "returns true if folder is public" do
        user = create(:user)
        music = user.new_folder("Muisc")
        music.public_folder!

        expect(user.root_folder.public?).to eq(nil)
        expect(music.public?).to eq(true)
      end
    end

    context "#share_children" do
      it "shares all a folders children" do
        user1, user2 = create_list(:user, 2)
        music = user1.new_folder("Music")
        weezer = user1.new_folder("Weezer", music)

        user1.share_folder(user2, music)

        expect(weezer.authorized_viewers).to include(user2)
      end
    end

    context "#share_with_authorized_viewers" do
      it "shares new folder with authorized users of parent" do
        user1, user2, user3, user4 = create_list(:user, 4)
        music = user1.new_folder("Music")
        user1.share_folder(user2, music)
        user1.share_folder(user3, music)
        weezer = user1.new_folder("Weezer", music)

        expect(weezer.authorized_viewers).to include(user2)
        expect(weezer.authorized_viewers).to include(user3)
        expect(weezer.authorized_viewers).to_not include(user4)
      end
    end

    context "#path_to_folder" do
      it "should return an array folders in order of path" do
        user = create(:user)
        music = user.new_folder("music")
        weezer = user.new_folder("weezer", music)

        expect(weezer.path_to_folder).to eq([user.root_folder, music, weezer])
      end
    end
  end
end
