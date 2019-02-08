class RenameReviewsToBorrowerReviews < ActiveRecord::Migration[5.2]
  def change
  	remove_column :reviews, :item_id
    rename_table :reviews, :borrower_reviews
  end
end
