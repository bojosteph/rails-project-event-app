

class User < ApplicationRecord
  has_secure_password
  has_many :events, foreign_key: 'planner_id'
  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i.freeze
  validates_presence_of :username, presence: true, uniqueness: true
  validates_presence_of :password, :name, presence: true
  has_many :rsvp_events, foreign_key: :participant_id
  has_many :attending_events, through: :rsvp_events, source: :event
  validates :email, presence: true,
                    length: { maximum: 100 },
                    format: EMAIL_REGEX,
                    confirmation: true,
                    uniqueness: true

  def self.find_or_create_by_omniauth(auth_hash)
    where(email: auth_hash['info']['email']).first_or_create do |user|
      user.password = SecureRandom.hex
    end
  end
end
