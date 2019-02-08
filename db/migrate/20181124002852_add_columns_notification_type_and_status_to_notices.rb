class AddColumnsNotificationTypeAndStatusToNotices < ActiveRecord::Migration[5.2]
  def change
  	add_column :notices, :notification_type, :string
  	add_column :notices, :status, :string
  end
end
