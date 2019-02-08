class UsersController < ApplicationController
  include UsersHelper

  before_action :authenticate_user!, except: [:new, :create]
  before_action :only_current_user, only: [:edit, :update, :delete]
  def index
    @users = User.find_with_name(params[:name])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      set_user_session @user
    else
      render 'new'
    end
  end

  def show
    @connection = Connection.new
    @user = User.find(params[:id])
    
    #variables for calendar view that holds my active items deadlines .
    @my_active_items=ActiveItem.where('lender_id=?', @user.id).or(ActiveItem.where('borrower_id=?', @user.id))

    @l_r_avg = @user.lender_reviews.average(:rating)
    @b_r_avg = @user.borrower_reviews.average(:rating)
    if @l_r_avg == nil
      @l_r_avg = 0
    end
    if @b_r_avg == nil
      @b_r_avg = 0
    end
    @r_avg = (@l_r_avg + @b_r_avg)/2
  end

  def edit
    puts "edit"
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_modify_params)
      redirect_to current_user
    else
      flash[:notice] = "Could not update details"
      Rails.logger.info(@user.errors.messages.inspect)
      redirect_to edit_user_path
    end
  end

  def destroy
    #TODO: Delete user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name,
                                 :phone_number, :street_addr, :city, :postal_code)
  end

  def user_modify_params
    params.require(:user).permit(:first_name, :last_name, :street_addr, :city, :postal_code)
  end

  def only_current_user
    if current_user.id.to_s != params[:id].to_s
      redirect_to :root
    end
  end

end

class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end
