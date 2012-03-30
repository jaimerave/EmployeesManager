class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
   def facebook
    # You need to implement the method below in your model
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.present?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      flash[:error] = "User does not exist"
      redirect_to root_path
    end
  end
end