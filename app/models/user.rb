class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :cellphone, presence: true
  validates :role, presence: true

  enum role: [:admin, :user]
  enum status: [:pending, :confirmed]
end
