class AddIsDeletedToItems < ActiveRecord::Migration[5.2]
  def change
  	add_column :items, :is_deleted, :boolean, default: false
  end
end
