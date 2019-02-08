module UsersHelper
    def get_email(user_id)
        if user_id != nil
            user = User.find_by(id: user_id)
            if user
                user.email   
            end         
        end
    end
    def get_location(user_id)
        if !user_id.nil?
            user = User.find(user_id)
            if user
                if !user.latitude.nil? && !user.longitude.nil?
                    return {lat: user.latitude, lng: user.longitude}
                end
            end
        end
        return nil
    end

    # This function is used in User create function to set the session of new user
    def set_user_session(user)
      if user.save
        session[:user_id] = user.id
        flash[:notice] = "Sign Up Success!!"
        redirect_to :root
      else
        flash[:alert] = "Problem"
        render 'new'
      end
    end

end

