class AddColumnsToRequestsDb < ActiveRecord::Migration[5.2]
  def change
  	add_column :requests, :borrower_id, :integer
  	add_column :requests, :lender_id, :integer
	add_column :requests, :item_id, :integer
	add_column :requests, :status, :integer
	add_column :requests, :responded_on, :datetime
	add_column :requests, :time_period, :string
	add_column :requests, :read_at, :datetime
	add_column :requests, :due_date, :datetime
  end
end
