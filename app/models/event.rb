class Event < ApplicationRecord
    belongs_to :planner, :class_name => "User", :foreign_key => 'planner_id', optional: true
end
