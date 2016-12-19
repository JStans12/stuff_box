class ChangeUserFoldersToShares < ActiveRecord::Migration[5.0]
  def change
    rename_table :user_folders, :shares
  end
end
