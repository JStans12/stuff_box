class AddReferencesFoldersToUploads < ActiveRecord::Migration[5.0]
  def change
  	add_reference :uploads, :folder, index: true
  end
end
