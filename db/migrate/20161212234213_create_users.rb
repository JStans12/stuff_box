class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.integer :role
      t.string :password_digest
      t.string :email
      t.string :sms_number

      t.timestamps
    end
  end
end
