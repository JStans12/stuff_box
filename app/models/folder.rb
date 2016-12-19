class Folder < ApplicationRecord
  has_many :children, class_name: "Folder", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Folder", foreign_key: "parent_id", required: false
  belongs_to :owner, class_name: "User", foreign_key: "owner_id", required: false

  enum visibility: [:private_folder, :public_folder]

  has_many :user_folders
  has_many :authorized_viewers, through: :user_folders, source: :user

  has_many :uploads

  def self.owners
    User.find(all.pluck(:owner_id).uniq)
  end

  def self.by_owner
    owners.reduce({}) do |r, owner|
      r[owner] = self.where( {owner_id: owner.id} )
      r
    end
  end

  def self.public
    where(visibility: "public_folder")
  end

  def path_to_folder
    path = []
    folder = self
    until folder == nil
      path << folder
      folder = folder.parent
    end
    path.reverse
  end
end
