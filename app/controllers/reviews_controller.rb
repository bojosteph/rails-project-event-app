class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index
    #raise params.inspect
    @event = Event.find_by(id: params[:event_id])
    @reviews = Review.all
  end

  def new
    #raise params.inspect
    @user = current_user
    @event = Event.find_by(id: params[:event_id])
    @review = Review.new
  end

  def create
     #raise params.inspect
    @user = current_user
    @event = Event.find_by(id: params[:event_id])
    @review = @event.reviews.build(review_params)
    @review.reviewer = @user

    if @review.save
      redirect_to event_review_path(id: @review.id)
    else
      flash[:error] = 'You Already reviewed This Event.'
      redirect_to event_reviews_path(@event)
    end
  end

  def show
    #raise params.inspect
    @event = Event.find_by(id: :event_id)
    @review = Review.find(params[:id])
  end

  def destroy
    # raise params.inspect
    if params[:id]
      @user = current_user
      @event = Event.find(params[:id])
      review = Review.find_by(participant_id: @user.id, attending_event_id: @event.id)
      if review.nil?
        redirect_to user_events_path(@user, @event), alert: 'You Can Only Cancel Your Review '
      else

        review.reviewer == @user
        review.delete
        flash[:message] = "You Cancelled Your Rsvp for #{@event.name}."
        redirect_to user_event_path(@user, @event)
      end
    end
  end

  private
    def review_params
      params.require(:review).permit(:rating, :body)
    end

end
