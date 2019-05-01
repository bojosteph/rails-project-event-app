class RsvpEvent < ApplicationRecord
    belongs_to :attending_event, class_name: "Event", :foreign_key => 'attending_event_id'
    belongs_to :participant, class_name: "User", :foreign_key => 'participant_id'
    validates :participant_id, uniqueness: { scope: :attending_event_id }


    def participant_rsvp
        RsvpEvent.where(event: @event)
    end
end
