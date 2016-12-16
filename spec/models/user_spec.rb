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
    it { should respond_to(:user_folders)}
    it { should respond_to(:root)}
  end

  describe "model methods" do
    context "#root_folder" do
      it "has a root folder" do
        user = create(:user)
        expect(user.root_folder.name).to eq("root")
      end
    end
  end
end
