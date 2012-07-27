class User < ActiveRecord::Base
  has_many :ratings
  has_many :restaurants, :through => :ratings
  has_many :comments
  has_and_belongs_to_many :groups,
    :join_table => "users_groups"



  has_many :evaluations, class_name: "RSEvaluation", as: :source


	rolify
	# acts_as_voter
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :last_name, :email, :password, :password_confirmation, :first_name, :groups_attributes
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

  def rated?(restaurant, mark)
    evaluations.where(target_type: restaurant.class, target_id: restaurant.id, reputation_name: mark).present?
  end
end
