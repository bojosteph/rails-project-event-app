

class EventsController < ApplicationController
  before_action :confirm_logged_in
  before_action :set_time_zone, if: :logged_in?

  def index
    @user = current_user
    @events = Event.all
  end

  def show
    @user = current_user
    @event = Event.find(params[:id])
    @rsvp_events = RsvpEvent.where(attending_event_id: @event.id)
  end

  def new
    @user = current_user
    @event = Event.new
    @event.build_category
  end

  def create
    #raise params.inspect
    @user = current_user
    @event = @user.events.build(event_params(:name, :location, :description, :planner_id, :start_date, :end_date, :category_id, category_attributes: [:name]))

    if @event.save
      redirect_to user_event_path(@user, @event)
    else
      render :new
    end
  end

  def edit
    # raise params.inspect
    @user = current_user
    @event = Event.find(params[:id])
  end

  def update
    @user = current_user
    @event = Event.find(params[:id])
    if @event.update(event_params(:name, :date, :location, :description, :planner_id, :start_date, :end_date, :category_id, category_attributes: [:name]))
      redirect_to user_event_path(@user, @event)
    else
      render :edit
    end
  end

  def destroy
    # raise params.inspect
    @user = current_user
    Event.find(params[:id]).delete
    redirect_to user_events_path(@user)
  end

  

  private

  def event_params(*args)
    params.require(:event).permit(*args)
  end

  def set_time_zone
    Time.zone = 'Central Time (US & Canada)'
  end

  
end
