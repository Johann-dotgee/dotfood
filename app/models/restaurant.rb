class Restaurant < ActiveRecord::Base
  attr_accessible :name
  acts_as_votable
end
