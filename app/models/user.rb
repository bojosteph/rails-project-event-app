class User < ApplicationRecord
     has_secure_password
     has_many :events, :foreign_key => 'planner_id'
end
