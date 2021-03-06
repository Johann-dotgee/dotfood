#encoding:utf-8
class RestaurantsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :parse_interval, :only => :create

  def index
    @restaurants = Restaurant.find(:all)
    @restaurants.each do |restaurant|
      unless restaurant.ratings.blank?
        averages = get_averages restaurant
        restaurant["average"] = ((averages[:service] + averages[:food] + averages[:ambience] + averages[:quantity] + averages[:wait]) / 5).to_s
      end
    end
    @alone = get_alones
    respond_with(@restaurants)
  end

  # GET /restaurants
  # GET /restaurants.xml
  def dashboard
    @restaurants = Restaurant.find :all, :include => [:votes], :conditions => {"votes.created_at" => Date.today}
    @restaurants = @restaurants.sort{|a,b| b.diff <=> a.diff}
    @alone = get_alones
    respond_with(@restaurants)
  end

  def upvote
    @restaurant = Restaurant.find(params[:id])
    vote 'like', params[:id]
    redirect_to dashboard_restaurants_path
  end

  def downvote
    @restaurant = Restaurant.find(params[:id])
    vote 'bad', params[:id]
    redirect_to dashboard_restaurants_path
  end

  # GET /restaurants/1
  # GET /restaurants/1.xml
  def show
    @comment = Comment.new
    @restaurant = Restaurant.find(params[:id])
    @distance = @restaurant.distance_to("2 Cité d'Aleth, Rennes 35000, France")
    unless @restaurant.ratings.blank?
      @averages = get_averages(@restaurant)
    end
    respond_with(@restaurant)
  end


  # GET /restaurants/new
  # GET /restaurants/new.xml
  def new
    @restaurant = Restaurant.new
    respond_with(@restaurant)
  end

  # GET /restaurants/1/edit
  def edit
    if current_user.has_role? :admin
      @restaurant = Restaurant.find(params[:id])
    else
      flash[:error] = "Vous n'avez pas les droits nécessaires pour accéder à cette page"
      redirect_to dashboard_restaurants_path
    end
  end

  # POST /restaurants
  # POST /restaurants.xml
  def create
    @restaurant = Restaurant.new(params[:restaurant])
    @restaurant.save
    redirect_to new_restaurant_rating_path(@restaurant)
  end

  # PUT /restaurants/1
  # PUT /restaurants/1.xml
  def update
    if current_user.has_role? :admin
      @restaurant = Restaurant.find(params[:id])
      @restaurant.update_attributes(params[:restaurant])
      respond_with(@restaurant)
    else
      flash[:error] = "Vous n'avez pas les droits nécessaires pour accéder à cette page"
      redirect_to dashboard_restaurants_path
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.xml
  def destroy
    if current_user.has_role? :admin
      @restaurant = Restaurant.find(params[:id])
      @restaurant.destroy
      respond_with(@restaurant)
    else
      flash[:error] = "Vous n'avez pas les droits nécessaires pour accéder à cette page"
      redirect_to dashboard_restaurants_path
    end
  end




  private

    def get_alones
      alones = EatAlone.all(:conditions => {:updated_at => Date.today})
      ids = Array.new
      alones.each do |alone|
        ids << alone.user_id
      end
      @alone = User.where("id in (:ids)", :ids => ids) unless ids.blank?
    end

    def get_averages restaurant
      service = 0
      food = 0
      quantity = 0
      ambience = 0
      wait = 0
      div = restaurant.ratings.size
      restaurant.ratings.each do |note|
        service += note.quality_service
        food += note.quality_food
        ambience += note.ambience
        quantity += note.quantity
        wait += note.waiting
      end
      {:service => (service/div), :food => (food/div), :ambience => (ambience/div), :quantity => (quantity/div), :wait => (wait/div)}
    end

    def parse_interval
      @parameters = params[:restaurant][:intervals_attributes]
      params[:restaurant][:intervals_attributes].each do |k, par|
        if par["interval_type"].blank?
          par["closed"] = true
        else
          par["closed"] = false
        end
      end
    end

    def todays_votes(id)
      conditions = {:updated_at => Time.now.midnight..(Time.now.midnight + 1.day), :votable_id => id}
      return current_user.find_votes conditions
    end

    def vote(type, id)
      has_voted = todays_votes(id)
      if has_voted.empty?
        @restaurant.vote :voter => current_user, :vote => type
        flash[:notice] = "Votre vote a bien été pris en compte. Merci d'avoir voté :)."
      else
        type_flag = has_voted.first.vote_flag == true ? "like" : "bad"
        unless type_flag == type
          @restaurant.vote :voter => current_user, :vote => type
          flash[:notice] = "Votre vote a bien été modifié."
      	else
      	  type_vote = type == "like" ? "pour" : "contre"
      	  flash[:error] = "Vous avez déjà voté #{type_vote} ce restaurant."
      	end
      end
    end

end