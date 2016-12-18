class Folder < ApplicationRecord
  has_many :children, class_name: "Folder", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Folder", foreign_key: "parent_id", required: false

  enum visibility: [:private_folder, :public_folder]

  has_many :user_folders, dependent: :destroy
  has_many :users, through: :user_folders

  def owner
    users.where(user_folders: { permissions: 0 }).first
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

  def self.public
    where(visibility: "public_folder")
  end

end
