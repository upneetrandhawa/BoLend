class AddItemRefToActiveItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :active_items, :item_id
    add_reference :active_items, :item, foreign_key: true
  end
end
