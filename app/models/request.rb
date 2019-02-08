class Request < ApplicationRecord
	validates :lender_id, :borrower_id, :status, presence: true
	validate :fields_lender_id_and_borrower_id_are_different
	enum status: [:pending, :accepted, :rejected, :done]
	#scope :unread, ->{ where (readAt: nil)}

	def fields_lender_id_and_borrower_id_are_different
    if self.lender_id == self.borrower_id
      errors.add("You cannot request your own item")
    end
  end
end