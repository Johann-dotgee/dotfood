class RSEvaluation < ActiveRecord::Base
  scope :today,  where(created_at: Date.today)
  scope :votes_today,  where(reputation_name: 'votes_today', created_at: Date.today)
  scope :tomorow, created_at: Date.today+1.day

  scope :plus_today, lambda { |restaurant| where(reputation_name: 'votes', value: 1, created_at: Date.today)}
  scope :moins_today, lambda { |restaurant| where(reputation_name: 'votes', value: -1, created_at: Date.today)}
  scope :just_today, where(created_at: Date.today)
  # def votes_today(restaurant)
  #   where(target_type: restaurant.class, target_id: restaurant.id, reputation_name: 'votes', created_at: Date.today)
  # end
end