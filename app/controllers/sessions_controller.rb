

class SessionsController < ApplicationController
  
  def new
  end

  def create
    if auth_hash = request.env['omniauth.auth']
      @user = User.find_or_create_by_omniauth(auth_hash)
      session[:user_id] = @user.id

      redirect_to root_path
    else
      @user = User.find_by(username: params[:session][:username])

      if @user&.authenticate(params[:session][:password])
        log_in @user
        redirect_to(user_events_path(:user_id => @user.id))
      else
        flash[:login_error] = 'Incorrect login. Please try again.'
        render :new
      end
    end
  end

  

  def destroy
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = 'Logged out'
    redirect_to(sessions_new_path)
  end
end
