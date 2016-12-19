class AddOwnerIdToFolders < ActiveRecord::Migration[5.0]
  def change
    add_column :folders, :owner_id, :integer
  end
end
