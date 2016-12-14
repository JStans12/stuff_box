class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :cellphone, presence: true
  validates :role, presence: true

  enum role: [:admin, :user]
  enum status: [:pending, :confirmed]

  def self.find_or_create_new_user(userparams)
  	user = find_by(username: userparams[:username])
  	if user && user.authenticate(userparams[:password])
  		user
  	else 
  		user = User.new(userparams)
  	end
  end
end
