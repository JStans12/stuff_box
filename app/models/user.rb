class User < ApplicationRecord
  enum role: [:admin, :user]
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :sms_number, presence: true
  validates :role, presence: true
end
