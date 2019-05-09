

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  #include SessionsHelper
  helper_method :current_user, :user_signed_in?, :user_session, :logged_in?, :destroy_user_session_path

  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :full_name])
  end
end


  
