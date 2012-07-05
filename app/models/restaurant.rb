class Restaurant < ActiveRecord::Base
  resourcify
  acts_as_votable
  attr_accessible :budget, :jeudi, :lundi, :mardi, :mercredi, :name, :quality, :quantity, :time_to_go, :vendredi, :address

  geocoded_by :address
  after_validation :geocode

  def diff 
    self.votes.map{|vote| vote.vote_flag}.count(true) - self.votes.map{|vote| vote.vote_flag}.count(false)
  end
end
