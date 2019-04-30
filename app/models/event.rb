class Event < ApplicationRecord
    belongs_to :planner, :class_name => "User", :foreign_key => 'planner_id'
    validates_presence_of :name, :location, :description, :start_of_event, :end_of_event
    has_many :rsvp_events, foreign_key: :attending_event_id
    has_many :participants, through: :rsvp_events, source: :user 



    validate :date_must_be_current, if: :has_date_range?
    validate :correct_date_range, if: :has_date_range?
    validate :no_overlapping_events

    scope :overlapping, -> (start_of_event, end_of_event) {
        where(
            "start_of_event <= :end_of_event AND :start_of_event <= end_of_event",
        start_of_event: start_of_event, end_of_event: end_of_event
        )
    }

    def no_overlapping_events
        event = Event.overlapping(start_of_event, end_of_event)
        overlaps = event.where("event_creator_id = ?", event_creator_id)

        if overlaps.any?
        dates = overlaps.map {|e|
        [   e.start_of_event, e.end_of_event].join(" to ")
            }.join(", ")
        errors.add(:base, "must not overlap existing events. Overlaps: #{dates}")
        end
    end


    def self.active_event
        where("end_of_event > ?", DateTime.now)
    end

    def self.past_event
        where("end_of_event < ?", DateTime.now)
    end

    def has_date_range?
        start_of_event.present? && end_of_event.present?
    end

    def date_must_be_current
        unless start_of_event >= DateTime.now
            errors.add(:start_of_event, "must be on or after current date")
        end
    end

    def correct_date_range
        unless end_of_event >= start_of_event
            errors.add(:end_of_event, "must be on or after start of event")
        end
    end

end
