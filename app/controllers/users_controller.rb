

class UsersController < ApplicationController
  before_action :confirm_logged_in, except: %i[new create]

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params(:username, :email, :password, :name, :google_token, :google_refresh_token))
    if user.save
      session[:user_id] = user.id
      flash[:notice] = 'User created successfully.'
      redirect_to events_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params(:username, :email, :password, :name, :google_token, :google_refresh_token))
      flash[:notice] = 'User updated successfully.'
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params(*args)
    params.require(:user).permit(*args)
  end
end
