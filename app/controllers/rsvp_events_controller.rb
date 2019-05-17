
class RsvpEventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rsvp_events = RsvpEvent.all
  end

  def rsvp_event
    @rsvp_event = RsvpEvent.new
  end

  def create
    # raise params.inspect
    # user = current_user
    @event = Event.find(params[:id])
    @rsvp_event = current_user.rsvp_events.build(attending_event_id: params[:event_id])

    if @rsvp_event.save
      flash[:message] = "THANK YOU FOR JOINING #{@event.name.upcase}"
      redirect_to event_path(@event)
    else
      flash[:error] = 'YOU ALREADY JOINED THIS EVENT.'
      redirect_to event_path(@event)
    end
  end

  def show
    @rsvp_event = RsvpEvent.find(params[:id])
  end

  def destroy
    # raise params.inspect
    if params[:id]
      @user = current_user
      @event = Event.find(params[:id])
      rsvp = RsvpEvent.find_by(participant_id: @user.id, attending_event_id: @event.id)
      if rsvp.nil?
        redirect_to events_path(@event), alert: 'YOU CAN ONLY CANCEL YOUR RSVP '
      else

        rsvp.participant == @user
        rsvp.destroy
        flash[:message] = "YOU CANCELLED YOUR RSVP FOR  #{@event.name.upcase}."
        redirect_to event_path(@event)
      end
    end
  end
end
