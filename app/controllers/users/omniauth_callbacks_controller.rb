class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    oauth(:find_for_facebook_oauth, 'Facebook')
  end

  private

  def oauth(user_finding_method, kind_of_authentication)
    @user = User.send(user_finding_method.to_sym, request.env["omniauth.auth"])

    if @user.persisted?
      set_flash_message(:notice, :success, :kind => kind_of_authentication) if is_navigational_format?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      redirect_to new_session_path, alert: 'Something went wrong.'
    end
  end
end
