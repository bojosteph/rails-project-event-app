class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  helper_method :current_user, :logged_in?

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def logged_in?
    !!current_user
  end


  private 

  def confirm_logged_in
    unless logged_in?
      flash[:notice] = "Please log in."
      redirect_to(sessions_new_path)
    end
  end
  
end



