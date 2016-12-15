class User < ApplicationRecord
  has_secure_password

  after_create :create_root_folder

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :cellphone, presence: true
  validates :role, presence: true

  enum role: [:admin, :user]
  enum status: [:pending, :confirmed]

  has_many :user_folders
  has_many :folders, through: :user_folders, dependent: :destroy

  def root_folder
    Folder.find(root)
  end

  def create_root_folder
    root = folders.create(name: "root")
    user_folders.create(folder_id: root.id, permissions: 0)
    update(root: root.id)
    save
  end

  def new_folder(name, parent = root_folder)
    folder = folders.create(name: name, parent_id: parent.id)
    user_folders.create(folder_id: folder.id, permissions: 0)
  end
end
