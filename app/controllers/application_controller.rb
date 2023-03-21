class ApplicationController < ActionController::Base
    # Set the current user in the Current object before any action is performed
    before_action :set_current_user

    def set_current_user
        if session[:user_id]
            Current.user = User.find_by(id: session[:user_id])
        end
    end

    # Redirect to the sign in page if the user is not signed in
    # bang "!" is used because this method will throw an exception on failure instead of failing silently
    def require_user_signed_in!
        redirect_to sign_in_path, alert: "You must be signed in to do that." if Current.user.nil?
    end

end 
