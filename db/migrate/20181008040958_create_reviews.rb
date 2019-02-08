class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id, null: false
      t.integer :reviewer_id, null: false
      t.integer :item_id
      t.decimal :rating
      t.text :comments
      t.datetime :created_at, null: false
      t.timestamps
    end
  end
end
