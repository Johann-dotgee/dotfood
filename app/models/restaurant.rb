class Restaurant < ActiveRecord::Base
  has_many :ratings
  has_many :intervals
  has_many :user, :through => :ratings
  accepts_nested_attributes_for :ratings
  accepts_nested_attributes_for :intervals
  resourcify
  acts_as_votable
  attr_accessible :name, :restaurant_type, :speciality, :picture, :description, :budget_min, :budget_max, :address, :time_to_go, :ratings_attributes, :intervals_attributes

  geocoded_by :address
  after_validation :geocode

  def diff
    self.votes.map{|vote| vote.vote_flag}.count(true) - self.votes.map{|vote| vote.vote_flag}.count(false)
  end
end
