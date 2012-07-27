class Evaluation < RSEvaluation::ActiveRecord::Base
  scope :votes_today, lambda { |restaurant| where(target_type: restaurant.class, target_id: restaurant.id, reputation_name: 'votes', created_at: Date.today)}
  scope :plus_today, lambda { |restaurant| where(target_type: restaurant.class, target_id: restaurant.id, reputation_name: 'votes', value: 1, created_at: Date.today)}
  scope :moins_today, lambda { |restaurant| where(target_type: restaurant.class, target_id: restaurant.id, reputation_name: 'votes', value: -1, created_at: Date.today)}
  scope :just_today, where(created_at: Date.today)
  # def votes_today(restaurant)
  #   where(target_type: restaurant.class, target_id: restaurant.id, reputation_name: 'votes', created_at: Date.today)
  # end
end