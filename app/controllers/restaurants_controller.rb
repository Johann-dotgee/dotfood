#encoding:utf-8
class RestaurantsController < ApplicationController
  before_filter :authenticate_user!
  # GET /restaurants
  # GET /restaurants.xml
  def index
    require 'date'
    #@restaurants = Restaurant.includes(:votes).all(:conditions => { :created_at => Date.today })
    #@restaurants = Restaurant.find(:all, :include => [:votes], :conditions => { :created_at => Date.today })
    @restaurants = Restaurant.find(:all, :include => [:votes])
    respond_with(@restaurants)
  end

  def upvote
    require 'date'
    @restaurant = Restaurant.find(params[:id])

    conditions = {:created_at => Date.today}
    hasvoted = current_user.find_votes conditions

    if current_user.voted_for? @restaurant
      if hasvoted.blank?
        current_user.vote_up_for @restaurant
        #@message = "Votre vote a bien été pris en compte. Merci d'avoir voté :)."
        @message = @restaurant.find_votes conditions
        @message = @message[0].created_at
      else
        @message = "Vous avez déjà voté aujourd'hui! Repassez demain ;)."
      end
    else
      current_user.vote_up_for @restaurant
      @message = "Votre vote a bien été pris en compte. Merci d'avoir voté :)."
    end

    
  end

  def downvote
    @restaurant = Restaurant.find(params[:id])
    if !current_user.voted_for? @restaurant
      @restaurant.downvote_from current_user
      @message = "Votre vote a bien été pris en compte. Merci d'avoir voté :)."
    else
      @message = "Vous avez déjà voté aujourd'hui! Repassez demain ;)."
    end
  end

  # GET /restaurants/1
  # GET /restaurants/1.xml
  def show
    @restaurant = Restaurant.find(params[:id])
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
    @restaurant = Restaurant.find(params[:id])
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
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update_attributes(params[:restaurant])
    respond_with(@restaurant)
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.xml
  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    respond_with(@restaurant)
  end
end
