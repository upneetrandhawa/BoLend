class NoticesController < ApplicationController
  def create
    @notice = Notice.new
    #@notice.body = create_notification_body
    #@notice.save

    #respond_to do |format|
    #	if @notice.save
    #    format.html { redirect_to root_path }
	#	end
    #end
  end

  def index
    @notices = Notice.where(recipient_id: current_user)
  end

  def new_notice
  	@notice = Notice.new
    @notice.body = create_notification_body

    if @notice.save
    	redirect_to requests_path
    end
  end

  def set_notification_read
    @notice = Notice.find(params[:id])
    @notice.read_at = DateTime.current
    if @notice.save
    else
      puts @notice.errors.full_messages
      puts "something went wrong"
    end
    #if @notice.save
    #  if @notice.status = 'accepted'
    #      render "/requests"
    #  else
    #    redirect_to requests_path
    #  end
    #end
  end

  def notifications
    @notices = Notice.where(recipient_id: current_user)
    respond_to do |format|
      format.js
    end
  end

  protected

  def create_notification_body
  	body_message = ''
  	if params[:notification_type] == 'borrow_request'

  		if params[:status] == 'accepted'
  			body_message = 'your request for ' + 
  							Item.find(params[:item_id]).description +
  							' was approved.'

  		elsif params[:status] == 'rejected'
  			body_message = 'your request for ' + 
  							Item.find(params[:item_id]).description +
  							' was rejected.'

  		elsif params[:status] == 'pending'
  			body_message = User.find(params[:sender_id]).first_name +
  							' requested to borrow ' + 
  							Item.find(params[:item_id]).description 
  		end

  	elsif params[:notification_type] == 'reminder'
  		#do reminding stuff here
  	end
  		 	 
    return body_message
  end

  private

  #def notice_params
  #  params.require(:notice).permit(:notification_type, :status, :sender_id, :recipient_id, :item_id)
  #end
end