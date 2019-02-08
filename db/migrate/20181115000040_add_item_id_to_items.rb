class AddItemIdToItems < ActiveRecord::Migration[5.2]
  def change
  	add_column :items, :item_id, :integer
  end
end
