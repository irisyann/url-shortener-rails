class PasswordResetsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:email])

        if @user.present?
            # @user.generate_password_token!
            PasswordMailer.with(user: @user).reset.deliver_now
        ### For security reasons, we don't want to tell the user if the email address was found or not.
        # else
        #     flash[:alert] = "We could not find a user with that email address."
        #     render :new
        end

        redirect_to root_path, notice: "If an account with that email is found, we have sent you an email with instructions to reset your password."
    end

    def edit
        @user = User.find_signed!(params[:token], purpose: "password_reset")

        rescue ActiveSupport::MessageVerifier::InvalidSignature
            redirect_to sign_in_path, alert: "Your token has expired. Please try again."
    end

    def update
        @user = User.find_signed!(params[:token], purpose: "password_reset")
        if @user.update(password_params)
            redirect_to sign_in_path, notice: "Your password was reset successfully. Please sign in again."
        else
            render :edit
        end
    end

    private 
    def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end
