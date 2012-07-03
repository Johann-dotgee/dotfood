class Restaurant < ActiveRecord::Base
  acts_as_votable
  attr_accessible :budget, :jeudi, :lundi, :mardi, :mercredi, :name, :quality, :quantity, :time_to_go, :vendredi
end
