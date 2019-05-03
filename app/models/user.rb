

class User < ApplicationRecord
  has_secure_password
  has_many :events, foreign_key: 'planner_id'
  validates_presence_of :username, :email, presence: true, uniqueness: true
  validates_presence_of :password, :name
  has_many :rsvp_events, foreign_key: :participant_id
  has_many :attending_events, through: :rsvp_events, source: :event

  def self.find_or_create_by_omniauth(auth_hash)
    where(email: auth_hash['info']['email']).first_or_create do |user|
      user.password = SecureRandom.hex
    end
  end
end
