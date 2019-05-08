

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #include SessionsHelper
  helper_method :current_user, :user_signed_in?, :user_session, :logged_in?, :destroy_user_session_path

  

  private

  def confirm_logged_in
    unless logged_in?
      flash[:notice] = 'Please log in.'
      redirect_to(sessions_new_path)
    end
  end
end
