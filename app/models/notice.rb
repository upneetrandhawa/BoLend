class Notice < ApplicationRecord
	validates :sender_id, :recipient_id, :status, :notification_type, presence: true
	#validate :fields_sender_id_and_recipient_id_are_different

	#enum status: [:pending, :accepted, :rejected, :done, :expired, :about_to_expired]
	#enum notification_type: [:borrow_request, :reminder]

	after_create_commit { ItemRequestBroadcastJob.perform_later(self) }


	#def fields_sender_id_and_recipient_id_are_different
	##    if self.recipient_id != self.sender_id
	#      errors.add("You cannot send a notification to yourself")
	#    end
  	#end
end
