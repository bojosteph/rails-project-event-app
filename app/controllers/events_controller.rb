
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
    # raise params.inspect
    @user = current_user
    @event = Event.find(params[:id])
    @rsvp_event = RsvpEvent.find_by(participant_id: @user.id, attending_event_id: @event.id)
    @review = Review.find_by(reviewer_id: @user.id, reviewing_event_id: @event.id)
  end

  def new
    #@user = current_user
    @event = Event.new
    @event.build_category
  end

  def create
    # raise params.inspect
    @user = current_user
    @event = @user.events.build(event_params(:name, :location, :description, :planner_id, :start_date, :end_date, :category_id, category_attributes: [:name]))

    if @event.save
      flash[:message] = "YOU HAVE CREATED #{@event.name}"
      redirect_to event_path(@event)
    else
      @event.build_category
      render :new
    end
  end

  def edit
    # raise params.inspect
    #@user = current_user
    @event = Event.find(params[:id])
    @event.build_category
  end

  def update
    @user = current_user
    @event = Event.find(params[:id])
    if @event.update(event_params(:name, :date, :location, :description, :planner_id, :start_date, :end_date, :category_id, category_attributes: [:name]))
      flash[:message] = "YOU HAVE UPDATED #{@event.name}"
      redirect_to event_path(@event)
    else
      @event.build_category
      render :edit
    end
  end

  def destroy
    # raise params.inspect
    @user = current_user
    @event = Event.find(params[:id])
    @event.destroy
    flash[:message] = "YOU HAVE DELETED #{@event.name.upcase}"
    redirect_to events_path(@user)
  end

  def past 
    @events = Event.past_event 
    render :past  
  end

  def active
    @events = Event.active_event
    render :index
  end

  def today
    @events = Event.todays_event
    render :index
  end

  def all 
    @events = Event.all
    render :all 
  end

 def top 
    @events = Event.top
    render :top_rated 
  end
  
  def highest_rated
    @events = Event.highest_rated
    render :event_ratings
  end

    

  private

  def event_params(*args)
    params.require(:event).permit(*args)
  end

  def set_time_zone
    Time.zone = 'Eastern Time (US & Canada)'
  end
end
