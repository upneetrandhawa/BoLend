class ChangeAddress < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :address
    add_column :users, :street_addr, :string
    add_column :users, :city, :string
    add_column :users, :province, :string
    add_column :users, :postal_code, :string
  end
end
