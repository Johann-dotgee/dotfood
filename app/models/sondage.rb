class Sondage < ActiveRecord::Base
  belongs_to :events
  belongs_to :restaurants
  attr_accessible :start_at, :end_at, :reminder_at, :event_id, :restaurant_id
end
