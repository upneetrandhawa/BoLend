module NoticesHelper
	def nav_item_requests_partial_path
	  # if item requests exist
	  @pending_received_item_requests = Notice.where(:recipient_id => current_user.id, :read_at=>nil).order('created_at desc')

	  if @pending_received_item_requests.present? 
	    'layouts/requests_notifications/notifications' 
	  else # contact requests do not exist 
	    'layouts/requests_notifications/no_notifications' 
	  end
	end
end
