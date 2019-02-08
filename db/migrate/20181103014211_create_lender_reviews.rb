class CreateLenderReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :lender_reviews do |t|
      t.references :user, foreign_key: true, null: false
      t.integer :reviewer_id, null: false
      t.decimal :rating
      t.text :comments
      t.datetime :created_at, null: false
      t.timestamps
    end
  end
end
