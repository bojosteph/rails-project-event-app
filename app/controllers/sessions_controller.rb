class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(:username => params[:session][:username])

    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to(events_path)
    else
      flash[:login_error] = "Incorrect login. Please try again."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = 'Logged out'
    redirect_to(sessions_new_path)
  end
end
