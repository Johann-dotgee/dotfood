class User < ActiveRecord::Base
  has_many :ratings
  has_many :restaurants, :through => :ratings
	rolify
	acts_as_voter
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :first_name
  # attr_accessible :title, :body

  def voted_for_today? model, cond = {}
    vote = self.find_votes cond.merge({:votable_id => model.id})
    # vote.last.updated_at
    unless vote.count == 0
      if vote.first.updated_at < Date.today
        vote = false
      else 
        vote = true
      end
    else
      vote = false
    end
  end
end
