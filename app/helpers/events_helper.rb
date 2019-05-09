

module EventsHelper
  def start_of_event(event)
    event.start_date.strftime('START OF EVENT : %A, %b %e, at %l:%M %p')
  end

  def end_of_event(event)
    event.end_date.strftime('END OF EVENT : %A, %b %e, at %l:%M %p')
  end
end
