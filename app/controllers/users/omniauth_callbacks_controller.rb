class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.find_or_create_by_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end

  def google
    @user = User.find_or_create_by_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end
end