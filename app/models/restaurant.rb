class Restaurant < ActiveRecord::Base
  resourcify
  acts_as_votable
  attr_accessible :budget, :jeudi, :lundi, :mardi, :mercredi, :name, :quality, :quantity, :time_to_go, :vendredi, :address

  geocoded_by :address
  after_validation :geocode

  def diff
    #test = {}
    #test["#{self.name}"] = {}
    #test["#{self.name}"]["true"] = self.votes.map{|vote| vote.vote_flag}.count(true)
    #test["#{self.name}"]["false"] = self.votes.map{|vote| vote.vote_flag}.count(false)   # "#{self.name}: #{self.votes.map{|vote| vote.vote_flag}.count(false)}" #- self.votes.map{|vote| vote.vote_flag}.count(false)
    self.votes.map{|vote| vote.vote_flag}.count(true) - self.votes.map{|vote| vote.vote_flag}.count(false)
  end
end
