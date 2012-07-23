class Interval < ActiveRecord::Base
  belongs_to :restaurants
  attr_accessible :day, :interval_type, :closed, :from, :to
end