class Rating < ActiveRecord::Base
  belongs_to :users
  belongs_to :restaurants
  attr_accessible :quality_food, :quality_service, :quantity, :ambience
end
