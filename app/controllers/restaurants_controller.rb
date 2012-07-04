#encoding:utf-8
class RestaurantsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @restaurants = Restaurant.find(:all)
    respond_with(@restaurants)
  end

  # GET /restaurants
  # GET /restaurants.xml
  def dashboard
    @restaurants = Restaurant.find(:all, :include => [:votes])
    @winners = Restaurant.find_by_sql("SELECT r.*, COUNT(v.id) as number FROM restaurants r LEFT JOIN votes v ON r.id = v.votable_id WHERE v.vote_flag = true GROUP BY r.id ORDER BY number DESC LIMIT 3")
    @losers = Restaurant.find_by_sql("SELECT r.*, COUNT(v.id) as number FROM restaurants r LEFT JOIN votes v ON r.id = v.votable_id WHERE v.vote_flag = false GROUP BY r.id ORDER BY number DESC LIMIT 3")
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
    @restaurant = Restaurant.find(params[:id])
    @distance = @restaurant.distance_to("2 Cité d'Aleth, Rennes 35000, France")
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
    respond_with(@restaurant)
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
        flash[:error] = "Vous avez déjà voté pour/contre ce restaurant aujourd'hui! Repassez demain ;)."
      end

    end
end
