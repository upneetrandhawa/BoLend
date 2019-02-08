class ItemRequestsController < ApplicationController
  before_action :authenticate_user!
  def new
  end
  def create
    followings = Connection.get_followers(current_user.id)
    followings.each do |following|
      if !following.follows.nil?
        email = User.find(following.user_id).email
        user = User.find(current_user.id)
        SendItemRequestsMailer.send_requesting_item(email, params[:request], user.first_name).deliver
      end
    end
    redirect_to user_path(current_user.id)
  end
end
