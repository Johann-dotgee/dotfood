#encoding:utf-8
class RestaurantsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :parse_interval, :only => :create

  def index
    @restaurants = Restaurant.all
    @restaurants = @restaurants.sort{|a,b| a.rank_for(:global_rating) <=> b.rank_for(:global_rating)}
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
    # @restaurants = Restaurant.all
    # @restaurants = Restaurant.find_with_reputation(:votes, :all, :conditions => ["rs_reputations.updated_at = ?", Date.today])
    @restaurants = Restaurant.all
    @restaurants.each do |restaurant|
      restaurant["votes"] = restaurant.evaluations
      restaurant["plus"] = restaurant.evaluations.where(target_type: restaurant.class, target_id: restaurant.id, reputation_name: 'votes', value: 1, created_at: Date.today)
      restaurant["moins"] = restaurant.evaluations.where(target_type: restaurant.class, target_id: restaurant.id, reputation_name: 'votes', value: -1, created_at: Date.today)
      # restaurant["votes"] = restaurant.evaluations.today(restaurant)
      # restaurant["plus"] = restaurant.evaluations.plus_today(restaurant)
      # restaurant["moins"] = restaurant.evaluations.moins_today(restaurant)

      ["votes", "plus", "moins"].each do |value|
        restaurant[value].each do |v|
          v["voter"] = User.where(id: v.source_id)
        end
      end
      
    end
    @restaurants = @restaurants.sort{|a,b| a.rank_for(:votes, :today) <=> b.rank_for(:votes, :today)}
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


  def rate
    @restaurant = Restaurant.find(params[:id])
    @restaurant.add_or_update_evaluation(params[:mark], params[:value], current_user, :just_today)
    redirect_to new_restaurant_rating_path(@restaurant), notice: "Thank you for rating"
  end

  def vote2
    @restaurant = Restaurant.find(params[:id])
    value = params[:type] == "up" ? 1 : -1
    @restaurant.add_or_update_evaluation(:votes, value, current_user, params[:scope].to_sym)
    redirect_to :back, notice: "Thank you for voting"
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