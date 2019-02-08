class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :encrypted_password
      # t.string :salt
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :address
      t.date :member_since
      t.float :average_rating, default: 0
      t.timestamps
    end
  end
end
