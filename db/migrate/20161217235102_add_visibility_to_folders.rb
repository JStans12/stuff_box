class AddVisibilityToFolders < ActiveRecord::Migration[5.0]
  def change
    add_column :folders, :visibility, :integer, default: 0
  end
end
