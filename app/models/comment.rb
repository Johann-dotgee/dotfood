class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true
  belongs_to :restaurant, :polymorphic => true

  default_scope :order => 'created_at ASC'
  attr_accessible :title, :comment, :user_id

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user

  has_reputation :likes,
      :source => :user,
      :aggregated_by => :sum
end
