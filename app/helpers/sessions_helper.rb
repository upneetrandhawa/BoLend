module SessionsHelper
    def logged_in?
        !current_user.nil?
    end
    def valid_address?
        if logged_in?
            if !current_user.longitude.nil? and !current_user.latitude.nil?
                return true
            end
        end
        return false
    end
end
