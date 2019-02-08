class AddRememberMeDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :remember_me_digest, :string
  end
end
