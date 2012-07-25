#encoding:utf-8
class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    respond_with(@ratings)
  end

  def show
    @rating = Rating.find(params[:id])
    respond_with(@rating)
  end

  def new
    @rating = Rating.new
    @restaurant = Restaurant.find(params[:restaurant_id])
    if current_user.ratings.where(:restaurant_id => @restaurant.id).blank?
      respond_with(@rating)
    else
      flash[:error] = "Vous avez déjà noté ce restaurant"
      redirect_to restaurant_path(@restaurant)
    end
  end

  def edit
    @rating = Rating.find(params[:id])
  end

  def create
    params[:rating][:user_id] = current_user.id
    params[:rating][:restaurant_id] = params[:restaurant_id]
    params[:user_id] = current_user.id
    @rating = Rating.new(params[:rating])
    @rating.save
    @restaurant = Restaurant.find(params[:restaurant_id])
    respond_with(@restaurant)
  end

  def update
    params[:rating][:user_id] = current_user.id
    params[:rating][:restaurant_id] = params[:restaurant_id]
    @rating = Rating.find(params[:id])
    @rating.update_attributes(params[:rating])
    respond_with(@rating)
  end

  def destroy
    @rating = Rating.find(params[:id])
    @rating.destroy
    respond_with(@rating)
  end
end
