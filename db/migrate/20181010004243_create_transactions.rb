class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :lender_id
      t.integer :borrower_id
      t.integer :item_id
      t.datetime :start_date
      t.datetime :due_date

      t.timestamps
    end
  end
end
