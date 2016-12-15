class Folder < ApplicationRecord
  has_many :children, class_name: "Folder", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Folder", foreign_key: "parent_id", required: false

  has_many :user_folders, dependent: :destroy
  has_many :users, through: :user_folders

  def owner
    users.where(user_folders: { permissions: 0 }).first
  end
end
