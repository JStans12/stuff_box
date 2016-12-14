class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      enable_extension "citext"
      t.citext :username
      t.integer :role, default: 0
      t.string :password_digest
      t.citext :email
      t.string :cellphone

      t.timestamps
    end
  end
end
