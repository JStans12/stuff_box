class User < ApplicationRecord
  has_secure_password

  after_create :create_root_folder

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :cellphone, presence: true
  validates :role, presence: true

  enum role: [:user, :admin]
  enum status: [:pending, :confirmed]

  has_many :shares, dependent: :destroy
  has_many :shared_with_me, through: :shares, source: :folder
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
    folder.share_with_authorized_viewers
    folder
  end

  def share_folder(user, folder)
    if folder.owner == self
      user.shares.create(folder_id: folder.id, user_id: user.id)
      folder.share_children(user, owner = self)
    end
  end

  def is_shared_with_me?(folder)
    return true if shared_with_me.include?(folder)
  end

  def allowed_to_see?(folder)
    return true if folder.public_folder? || folder.owner == self || is_shared_with_me?(folder)
  end
end
