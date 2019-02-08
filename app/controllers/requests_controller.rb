class RequestsController < ApplicationController
	before_action :authenticate_user!

	def index
		@sent_requests = Request.where(borrower_id: current_user.id).order('created_at desc')
		@received_requests = Request.where(lender_id: current_user.id, status: 'pending').order('created_at desc')
		@approved_requests = Request.where(lender_id: current_user.id, status: 'accepted').order('created_at desc')
	end

	def show
	end

	def new
		@request = Request.new
		@time_period_categories = TimePeriodCategory.readonly
		item = Item.find(params[:item_id])
	end

	def edit
	end

	def create
		@request = Request.new
		@request.borrower_id = current_user.id
		@item_temp = Item.find(request_params_for_create[:item_id])
		@request.lender_id = @item_temp.user_id
		@request.item_id = request_params_for_create[:item_id]
		@request.status = 'pending'
		@request.time_period = TimePeriodCategory.find(request_params_for_create[:time_period]).name
		notification_body = create_notification_body 'borrow_request',@request.status,@request.item_id,current_user.id

		if @request.save
    	#	#Call notices_controller to creat a notice
    	#	redirect_to url_for(:controller => 'notices', 
	    #						:action => 'new_notice',
	    #						:sender_id => current_user.id,
	    #						:recipient_id => @request.lender_id,
	    #						:item_id => @request.item_id,
	    #						:notification_type => 'borrow_request',
	    #						:status => 'pending') and return
	    Notice.create(:sender_id => current_user.id, :recipient_id => @request.lender_id,
	    	:item_id => @request.item_id, :notification_type => 'borrow_request',
	    	:status => 'pending', :body => notification_body)

	    redirect_to @request
	else
		puts @request.errors.full_messages
		puts "something went wrong"
		@item = Item.find(request_params_for_create[:item_id])
		@time_period_categories = TimePeriodCategory.readonly
		render 'new'
	end

end

def update
end

def active_and_done
	@active_accepted_requests = Request.where(borrower_id: current_user.id, status: 'accepted').order('created_at desc')
	@completed_accepted_requests = Request.where(borrower_id: current_user.id, status: 'done').order('created_at desc')
end

def destroy
end



def approve_request
		#### CODE WHEN ITEM REQUEST IS ACCEPTED ####
		## 1. update the request table            ##
		#accept the current request
		@accepted_request = Request.find(params[:id])
		if @accepted_request.status != 'accepted'
			@accepted_request.status = 'accepted'
			@accepted_request.responded_on = DateTime.now
			@accepted_request.due_date = calculate_due_date
			@accepted_request.save
			notification_body = create_notification_body 'borrow_request',@accepted_request.status,@accepted_request.item_id,current_user.id


	    	## 2. update the items table              ##
	    	@accepted_item = Item.find(@accepted_request.item_id)
	    	@accepted_item.taken = true
	    	@accepted_item.increment(:times_used, 1)
	    	@accepted_item.save

	    	## 3. update the active_items table       ##
	    	# check if active_item record exists, if exists then update the value, otherwise create new one#
	    	#@accepted_active_item = ActiveItem.where(item_id: @accepted_request.item_id)
	    	#if(@accepted_active_item)
	    		#ActiveItem.update(accepted_active_item.id, lender_id:session[:user_id], borrower_id: @accepted_request.borrower_id, 
	    		#					start_date: Time.now)
	    		#@accepted_active_item.update_all(lender_id:session[:user_id], borrower_id: @accepted_request.borrower_id, 
	    		#					start_date: Time.now)
		    	#@accepted_active_item.first.lender_id = session[:user_id]
	    		#@accepted_active_item.first.borrower_id = @accepted_request.borrower_id
	    		#@accepted_active_item.first.start_date = Time.now
	    		#TODO accepted_active_item.due_date update!!
	    		#@accepted_active_item.first.save
	    	#else
	    	ActiveItem.create(lender_id:current_user.id, borrower_id: @accepted_request.borrower_id, 
	    		start_date: DateTime.now, due_date:@accepted_request.due_date, item_id: @accepted_request.item_id)
	    	#end

	    	#Call notices_controller to creat a notice
	    	#redirect_to url_for(:controller => 'notices', 
	    	#					:action => 'new_notice',
	    	#					:sender_id => current_user.id,
	    	#					:recipient_id => @accepted_request.borrower_id,
	    	#					:item_id => @accepted_request.item_id,
	    	#					:notification_type => 'borrow_request',
	    	#					:status => 'accepted') and return
	    	Notice.create(:sender_id => current_user.id, :recipient_id => @accepted_request.borrower_id,
	    		:item_id => @accepted_request.item_id, :notification_type => 'borrow_request',
	    		:status => 'accepted', :body => notification_body, :request_id => params[:id])


			## 4. now find all the other requests for the item which got approved and reject them ##
			@requests_to_be_rejected = Request.where(item_id: Request.find(params[:id]).item_id, status: 'pending')
			@requests_to_be_rejected.each do |request|
				request.status = 'rejected'
				request.responded_on = DateTime.now
				request.save
				notification_body_declined = create_notification_body 'borrow_request',request.status,request.item_id,current_user.id

	    		#Call notices_controller to creat a notice
	    		#redirect_to url_for(:controller => 'notices', 
	    		#				:action => 'new_notice',
	    		#				:sender_id => current_user.id,
	    		#				:recipient_id => request.borrower_id,
	    		#				:item_id => request.item_id,
	    		#				:notification_type => 'borrow_request',
	    		#				:status => 'rejected') and return
	    		Notice.create(:sender_id => current_user.id, :recipient_id => request.borrower_id,
	    			:item_id => request.item_id, :notification_type => 'borrow_request',
	    			:status => 'rejected', :body => notification_body_declined, :request_id => params[:id])
	    	end
    	end

    end

    def decline_request
    	@declined_request = Request.find(params[:id])
    	if @declined_request.status != 'rejected'
	    	@declined_request.status = 'rejected'
	    	@declined_request.responded_on = DateTime.now
	    	@declined_request.save
	    	notification_body = create_notification_body 'borrow_request',@declined_request.status,@declined_request.item_id,current_user.id

	    	#Call notices_controller to creat a notice
			#redirect_to url_for(:controller => 'notices', 
			#					:action => 'new_notice',
			#					:sender_id => current_user.id,
			#					:recipient_id => @declined_request.borrower_id,
			#					:item_id => @declined_request.item_id,
			#					:notification_type => 'borrow_request',
			#					:status => 'rejected') and return
			Notice.create(:sender_id => current_user.id, :recipient_id => @declined_request.borrower_id,
				:item_id => @declined_request.item_id, :notification_type => 'borrow_request',
				:status => 'rejected', :body=>notification_body, :request_id => params[:id])
		end
	end

	private

	def calculate_due_date
		request = Request.find(params[:id])

		if request.time_period == '1 minute (for DEMO)' #DEMO
			due_date = DateTime.current + 1.minute

		elsif request.time_period == '1 day'
			due_date = DateTime.current.end_of_day + 1.day

		elsif request.time_period == '3 days'
			due_date = DateTime.current.end_of_day + 3.days

		elsif request.time_period == '1 week'
			due_date = DateTime.current.end_of_day + 1.week

		elsif request.time_period == '2 weeks'
			due_date = DateTime.current.end_of_day + 2.weeks

		elsif request.time_period == '1 month'
			due_date = DateTime.current.end_of_day + 1.month

		elsif request.time_period == '3 months'
			due_date = DateTime.current.end_of_day + 3.months

		elsif request.time_period == '6 months'
			due_date = DateTime.current.end_of_day + 6.months

		elsif request.time_period == '1 year'
			due_date = DateTime.current.end_of_day + 1.year

		end

		return due_date
	end

	def create_notification_body(notification_type, status, item_id, sender_id)
		body_message = ''
		if (notification_type) == 'borrow_request'

			if (status) == 'accepted'
				body_message = 'your request for ' + 
				Item.find(item_id).description +
				' was approved.'

			elsif (status) == 'rejected'
				body_message = 'your request for ' + 
				Item.find(item_id).description +
				' was rejected.'

			elsif (status) == 'pending'
				body_message = User.find(sender_id).first_name +
				' requested to borrow ' + 
				Item.find(item_id).description
			end

		elsif notification_type == 'reminder'
  		#do reminding stuff here
  		end

  	return body_message
  end


  def request_params_for_new
  	params.require(:item_id)
  end

  def request_params_for_create
  	params.require(:request).permit(:item_id,:time_period)
  end

  def request_params_for_approve_request
  	params.require(:request).permit(:borrower_id,:item_id,:time_period)
  end

  def request_params_for_decline_request
  	params.require(:request).permit(:borrower_id,:item_id)
  end

end
