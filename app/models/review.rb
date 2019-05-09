class Review < ApplicationRecord
  belongs_to :reviewing_event, class_name: 'Event', foreign_key: 'reviewing_event_id'
  belongs_to :reviewer, class_name: 'User', foreign_key: 'reviewer_id'
  validates :reviewer_id, uniqueness: { scope: :reviewing_event_id }
end
