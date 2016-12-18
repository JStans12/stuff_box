class DropFiles < ActiveRecord::Migration[5.0]
   def change
    drop_table :files
  end
end
