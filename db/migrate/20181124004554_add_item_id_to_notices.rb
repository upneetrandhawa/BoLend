class AddItemIdToNotices < ActiveRecord::Migration[5.2]
  def change
  	add_column :notices, :item_id, :integer
  end
end
