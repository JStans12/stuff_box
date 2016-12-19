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

    context ".path_to_folder" do
      it "should return an array folders in order of path" do
        user = create(:user)
        music = user.new_folder("music")
        weezer = user.new_folder("weezer", music)

        expect(weezer.path_to_folder).to eq([user.root_folder, music, weezer])
      end
    end
  end
end
