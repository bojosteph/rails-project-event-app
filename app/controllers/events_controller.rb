
class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_time_zone, if: :user_signed_in?

  def index
    @user = current_user
    if params[:category]
      @category = Category.find_by(id: params[:category][:id])
      @events = @category.events
    else
      @events = Event.active_event
    end
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
    # raise params.inspect
    @user = current_user
    @event = @user.events.build(event_params(:name, :location, :description, :planner_id, :start_date, :end_date, :category_id, category_attributes: [:name]))

    if @event.save
      redirect_to user_event_path(@user, @event)
    else
      @event.build_category
      render :new
    end
  end

  def edit
    # raise params.inspect
    @user = current_user
    @event = Event.find(params[:id])
    @event.build_category
  end

  def update
    @user = current_user
    @event = Event.find(params[:id])
    if @event.update(event_params(:name, :date, :location, :description, :planner_id, :start_date, :end_date, :category_id, category_attributes: [:name]))
      redirect_to user_event_path(@user, @event)
    else
      @event.build_category
      render :edit
    end
  end

  def destroy
    # raise params.inspect
    @user = current_user
    Event.find(params[:id]).delete
    redirect_to user_events_path(@user)
  end

  def past 
    @user = current_user
    @events = Event.past_event 
    render :index  
  end

  def active
    @user = current_user
    @events = Event.active_event
    render :index
  end

  def today
    @user = current_user
    @events = Event.todays_event
    render :index
  end

  def all 
    @user = current_user
    @events = Event.all
    render :index 
  end

 def top 
    @user = current_user
    @events = Event.top
    render :index 
  end 
    

  private

  def event_params(*args)
    params.require(:event).permit(*args)
  end

  def set_time_zone
    Time.zone = 'Eastern Time (US & Canada)'
  end
end
