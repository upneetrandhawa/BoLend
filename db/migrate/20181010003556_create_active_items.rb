class CreateActiveItems < ActiveRecord::Migration[5.2]
  def change
    create_table :active_items do |t|
      t.integer :lender_id
      t.integer :borrower_id
      t.string :item_id
      t.datetime :start_date
      t.datetime :due_date

      t.timestamps
    end
  end
end
