class AddUserRefToBorrowerReviews < ActiveRecord::Migration[5.2]
  def change
  	remove_column :borrower_reviews, :user_id
    add_reference :borrower_reviews, :user, foreign_key: true
  end
end
