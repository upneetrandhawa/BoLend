class AddReadAtToNotices < ActiveRecord::Migration[5.2]
  def change
  	add_column :notices, :read_at, :datetime
  end
end
