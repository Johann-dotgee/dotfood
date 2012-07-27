class Event < ActiveRecord::Base
  attr_accessible :name, :start_at, :end_at, :group_id
  belongs_to :groups
  has_many :sondages
  has_many :restaurants, :through => :sondages
end
