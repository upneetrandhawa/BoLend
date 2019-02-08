class AddDeviseColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime
    add_column :users, :remember_created_at, :datetime
    add_column :users, :confirmation_token, :string

    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string
    
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
