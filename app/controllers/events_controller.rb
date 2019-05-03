

class EventsController < ApplicationController
  before_action :confirm_logged_in
  before_action :set_time_zone, if: :logged_in?

  def index
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
  end

  def create
    @user = current_user
    @event = @user.events.build(event_params(:name, :location, :description, :planner_id, :start_date, :end_date))

    if @event.save
      redirect_to event_path(@event)
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
    @event = Event.find(params[:id])
    if @event.update(event_params(:name, :date, :location, :description, :planner_id, :start_date, :end_date))
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    # raise params.inspect
    Event.find(params[:id]).delete
    redirect_to events_path
  end

  def get_calendars
    # Initialize Google Calendar API
    service = Google::Apis::CalendarV3::CalendarService.new
    # Use google keys to authorize
    service.authorization = google_secret.to_authorization
    # Request for a new aceess token just incase it expired
    service.authorization.refresh!
    # Get a list of calendars
    calendar_list = service.list_calendar_lists.items
    calendar_list.each do |calendar|
      puts calendar
    end
end

  private

  def event_params(*args)
    params.require(:event).permit(*args)
  end

  def set_time_zone
    Time.zone = 'Central Time (US & Canada)'
  end

  def google_secret
    Google::APIClient::ClientSecrets.new(
      'web' =>
       { 'access_token' => @user.google_token,
         'refresh_token' => @user.google_refresh_token,
         'client_id' => Rails.application.secrets.google_client_id,
         'client_secret' => Rails.application.secrets.google_client_secret }
    )
  end
end
