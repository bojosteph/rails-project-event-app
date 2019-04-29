class User < ApplicationRecord
     has_many :events, :foreign_key => 'planner_id'
end
