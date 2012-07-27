class Group < ActiveRecord::Base
  has_and_belongs_to_many :users,
  :join_table => "users_groups"
  has_many :events


  attr_accessible :user_id, :group_id, :name, :group_type, :users_attributes, :user_ids
end
