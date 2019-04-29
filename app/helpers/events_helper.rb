module EventsHelper
    def start_of_event(event)
        event.start_date.strftime("Start Of Event : %A, %b %e, at %l:%M %p")
    end

    def end_of_event(event)
        event.end_date.strftime("End Of Event : %A, %b %e, at %l:%M %p")
    end
end
