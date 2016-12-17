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
  has_many :folders, through: :user_folders, dependent: :destroy

  def root_folder
    Folder.find(root)
  end

  def create_root_folder
    root = Folder.create(name: "root")
    user_folders.create(folder_id: root.id, permissions: 0)
    update(root: root.id)
    save
  end

  def new_folder(name, parent = root_folder)
    folder = Folder.create(name: name, parent_id: parent.id)
    user_folders.create(folder_id: folder.id, permissions: 0)
    folder
  end

  def share_folder(user, folder)
    if folder.owner == self
      user.user_folders.create(folder_id: folder.id, user_id: user.id, permissions: 1)
    end
  end

  def shared_with_me
    folders.where(user_folders: { permissions: 1 })
  end
end
