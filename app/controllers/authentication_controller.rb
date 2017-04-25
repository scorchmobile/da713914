# Global scope user to protect pages and access the current user
# Changes ApplicationController inheritance (from ActionController::Base to Authentication)
class AuthenticationController < ActionController::Base

    # Protect Pages
    def authenticate_user!
        redirect_to(new_session_path, alert: 'Please Login to view this page.')  if session[:logged_in].eql?(false)
    end

    # Grab User
    def current_user
        @current_user = session[:current_user]
    end

    # Are they signed in?
    def user_signed_in?
        session[:logged_in].eql?(true) ? true : false
    end

end
