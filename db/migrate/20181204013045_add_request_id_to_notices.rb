class AddRequestIdToNotices < ActiveRecord::Migration[5.2]
  def change
  	add_column :notices, :request_id, :integer
  end
end
