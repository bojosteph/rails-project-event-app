class User < ApplicationRecord
  validates_uniqueness_of :email
  validates_presence_of :username, :full_name
  has_many :events, foreign_key: 'planner_id'
  has_many :rsvp_events, foreign_key: :participant_id
  has_many :attending_events, through: :rsvp_events
  has_many :reviews, foreign_key: :reviewer_id
  has_many :reviewing_events, through: :reviews
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook]


  def self.find_or_create_by_omniauth(auth_hash)
    where(email: auth_hash['info']['email']).first_or_create do |user|
      user.password = Devise.friendly_token[0,20]
    end
  end
end

