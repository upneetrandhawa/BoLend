class ReviewsController < ApplicationController
	before_action :require_login

	def index
		@b_reviews = current_user.lender_reviews.all
		@l_reviews = current_user.borrower_reviews.all
	end

	def show
	   #for reviews for borrower

	end

	def new
		@user=User.find_by_id(params[:user_id])

	end

	def edit
		@user=User.find_by_id(params[:user_id])

		#@b_review=current_user.lender_reviews.new
	  #@l_review=current_user.borrower_reviews.new
	end

	def create
	 if (params[:type_of_review])=='borrower'
			#@user=User.find_with_name(params[:borrower_review][:Name_of_person])
			#@b_review=@user.borrower_reviews.new#borrower review from whom I lended.
			@user=User.find_by_id( params[:user_id])
			@b_review=@user.borrower_reviews.new
			#url="/users/2/reviews"
		  #@l_review=current_user.borrower_reviews.new#my lender view for that borrower
		  @b_review.user_id = params[:user_id]
			@b_review.rating = params[:rating]
			@b_review.comments = params[:comments]
			@b_review.reviewer_id=session[:user_id]
			 if @b_review.save
           flash[:notice]="Successfully Changed Review"
           redirect_to reviews_path
         else
					 flash[:notice]="Failed"
           redirect_to new_review_path
         end


	else
		 @user=User.find_by_id( params[:user_id])
		 @l_review=@user.lender_reviews.new
		#url="/users/2/reviews"
		#@l_review=current_user.borrower_reviews.new#my lender view for that borrower
		 @l_review.user_id = params[:user_id]
		 @l_review.rating = params[:rating]
		 @l_review.comments = params[:comments]
		 @l_review.reviewer_id=session[:user_id]
		 if @l_review.save
				 flash[:notice]="Successfully Changed Review"
				 redirect_to reviews_path
			 else
				 flash[:notice]="Failed"
				 redirect_to new_review_path
			 end

	 end

	end

	def update
		if (params[:type_of_review])=='borrower'
			 #@user=User.find_with_name(params[:borrower_review][:Name_of_person])
			 #@b_review=@user.borrower_reviews.new#borrower review from whom I lended.
			 @user=User.find_by_id( params[:user_id])
			 @b_review=@user.borrower_reviews.find_by_id( params[:id])
			 #url="/users/2/reviews"
			 #@l_review=current_user.borrower_reviews.new#my lender view for that borrower
			 @b_review.user_id = params[:user_id]
			 @b_review.rating = params[:rating]
			 @b_review.comments = params[:comments]
			 @b_review.reviewer_id=session[:user_id]
				if @b_review.save
						flash[:notice]="Successfully Created Borrower Review"
						redirect_to reviews_path
					else
						flash[:notice]="Failed"
						redirect_to new_review_path
					end


	 else
			@user=User.find_by_id( params[:user_id])
			@l_review=@user.lender_reviews.find_by_id( params[:id])
		 #url="/users/2/reviews"
		 #@l_review=current_user.borrower_reviews.new#my lender view for that borrower
			@l_review.user_id = params[:user_id]
			@l_review.rating = params[:rating]
			@l_review.comments = params[:comments]
			@l_review.reviewer_id=session[:user_id]
			if @l_review.save
					flash[:notice]="Successfully Created Lender Review"
					redirect_to reviews_path
				else
					flash[:notice]="Failed"
					redirect_to new_review_path
				end

		end

	end

	def destroy
		#TODO: remove a review. Check if the review was created by current_user
	end

end
