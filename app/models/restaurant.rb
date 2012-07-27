class Restaurant < ActiveRecord::Base
  has_many :ratings
  has_many :intervals
  has_many :comments
  has_many :user, :through => :ratings
  has_many :evaluations, class_name: "RSEvaluation", as: :target
  has_many :sondages
  has_many :events, :through => :sondages
  accepts_nested_attributes_for :ratings
  accepts_nested_attributes_for :comments
  accepts_nested_attributes_for :intervals
  resourcify
  # acts_as_votable
  acts_as_commentable
  attr_accessible :name, :restaurant_type, :speciality, :picture, :description, :budget_min, :budget_max, :address, :time_to_go, :ratings_attributes, :intervals_attributes

  geocoded_by :address
  after_validation :geocode
  # scope :votes, (lambda do |restaurant|
  #     restaurant.evaluations.where(target_type: restaurant.class, target_id: restaurant.id, reputation_name: 'votes', created_at: Date.today)
  #   end)

  # scope :plus, (lambda do |restaurant|
  #     restaurant.evaluations.where(target_type: restaurant.class, target_id: restaurant.id, reputation_name: 'votes', value: 1, created_at: Date.today)
  #   end)

  # scope :moins, (lambda do |restaurant|
  #     restaurant.evaluations.where(target_type: restaurant.class, target_id: restaurant.id, reputation_name: 'votes', value: -1, created_at: Date.today)
  #   end)

  # scope :voter, (lambda do |vote|
  #     vote["voter"] = User.where(id: vote.source_id)
  #   end)
  
  

  has_reputation :votes,
      :source => :user,
      :aggregated_by => :sum,
      :scopes => [:today, :tomorow, :day]


  has_reputation :quality_food,
                  :source => :user,
                  :aggregated_by => :average,
                  :source_of => [{ :reputation => :global_rating, :of => :self}]

  has_reputation :quality_service,
                  :source => :user,
                  :aggregated_by => :average,
                  :source_of => [{ :reputation => :global_rating, :of => :self}]

  has_reputation :quantity,
                  :source => :user,
                  :aggregated_by => :average,
                  :source_of => [{ :reputation => :global_rating, :of => :self}]

  has_reputation :ambience,
                  :source => :user,
                  :aggregated_by => :average,
                  :source_of => [{ :reputation => :global_rating, :of => :self}]

  has_reputation :waiting,
                  :source => :user,
                  :aggregated_by => :average,
                  :source_of => [{ :reputation => :global_rating, :of => :self}]



  has_reputation :global_rating,
      :source => [
        { :reputation => :quality_food}, 
        { :reputation => :quality_service}, 
        { :reputation => :quantity}, 
        { :reputation => :ambience}, 
        { :reputation => :waiting}],
      :aggregated_by => :average

end
