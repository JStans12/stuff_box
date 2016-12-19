FactoryGirl.define do

  sequence :name do |n|
    "folder#{n}"
  end

  sequence :parent_id do |n|
    n
  end
end
