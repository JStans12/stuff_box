class RemovePermissionsFromUserFolders < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_folders, :permissions
  end
end
