require 'rails_helper'

RSpec.describe Share, type: :model do

  describe "relationships" do
    it { should respond_to(:user)}
    it { should respond_to(:folder)}
  end
end
