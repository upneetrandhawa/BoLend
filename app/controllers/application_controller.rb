class ApplicationController < ActionController::Base
    include SessionsHelper
    before_action :set_cache_headers


    #check if the current user is logged in
    #if not logged in, redirect to the homepage
    def require_login
        if !logged_in?
            redirect_to :root
        end
    end
    #check if the current user is not logged in
    #if logged in, redirect to the homepage
    def require_not_logged_in
        if logged_in?
            redirect_to :root
        end
    end

    private

      def set_cache_headers
        response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
        response.headers["Pragma"] = "no-cache"
        response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
      end
end


