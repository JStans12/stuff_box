FactoryGirl.define do

  sequence :username do |n|
    "user#{n}"
  end

  sequence :email do |n|
    "#{n}@stuff_box.com"
  end

  factory :user do
    username
    role 0
    password_digest "password"
    email
    cellphone "555-555-5555"
    status 0
  end
end
