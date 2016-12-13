require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username)}
  it { should validate_presence_of(:role)}
  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:sms_number)}
  it { should have_secure_password}
  it { should validate_uniqueness_of(:username)}
  it { should validate_uniqueness_of(:email)}
end
