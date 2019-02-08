class BorrowerReview < ApplicationRecord
  validates :user_id, :reviewer_id, :rating, presence: true
  validate :fields_user_id_and_reviewer_id_are_different
  belongs_to :user

  #here user_id is the id of the borrower
  def fields_user_id_and_reviewer_id_are_different
    if self.user_id == self.reviewer_id
      errors.add("You cannot give yourself a review")
    end
  end
end
