class User < ApplicationRecord
  has_secure_password

  after_create :create_root_folder

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :cellphone, presence: true
  validates :role, presence: true

  enum role: [:user, :admin]
  enum status: [:pending, :confirmed]

  has_many :user_folders
  has_many :shared_with_me, through: :user_folders, source: :folder
  has_many :folders, class_name: "Folder", foreign_key: "owner_id"

  has_many :uploads, through: :folders

  def root_folder
    Folder.find(root)
  end

  def create_root_folder
    root = folders.create(name: "root", owner_id: id)
    update(root: root.id)
    save
  end

  def new_folder(name, parent = root_folder)
    folder = folders.create(name: name, parent_id: parent.id, owner_id: id)
    folder
  end

  def my_folders
    folders.where(user_folders: { permissions: 0})
  end

  def share_folder(user, folder)
    if folder.owner == self
      user.user_folders.create(folder_id: folder.id, user_id: user.id, permissions: 1)
    end
  end

  def is_shared_with_me?(folder)
    return true if folders.include?(folder)
  end

  def allowed_to_see?(folder)
    return true if folder.public? || folder.owner == self || is_shared_with_me?(folder)
  end
end
