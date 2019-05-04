

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

  def googleAuth
    # Get access tokens from the google server
    access_token = request.env['omniauth.auth']
    user = User.find_or_create_by_omniauth(access_token)
    log_in(user)
    # Access_token is used to authenticate request made from the rails application to the google server
    user.google_token = access_token.credentials.token
    # Refresh_token to request new access_token
    # Note: Refresh_token is only sent once during the first request
    refresh_token = access_token.credentials.refresh_token
    user.google_refresh_token = refresh_token if refresh_token.present?
    user.save
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = 'Logged out'
    redirect_to(sessions_new_path)
  end
end
