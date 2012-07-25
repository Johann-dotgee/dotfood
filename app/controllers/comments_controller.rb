#encoding:utf-8
class CommentsController < ApplicationController
  def index
    @comments = Comment.all
    respond_with(@comments)
  end

  def show
    @comment = Comment.find(params[:id])
    respond_with(@comment)
  end

  def new
    @comment = Comment.new
    @restaurant = Restaurant.find(params[:restaurant_id])
    if current_user.comments.where(:restaurant_id => @restaurant.id).blank?
      respond_with(@comment)
    else
      flash[:error] = "Vous avez déjà noté ce restaurant"
      redirect_to restaurant_path(@restaurant)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.comments.create(:title => params[:comment][:title], :comment => params[:comment][:comment], :user_id => current_user.id)
    respond_with(@restaurant)
  end

  def update
    params[:comment][:user_id] = current_user.id
    params[:comment][:restaurant_id] = params[:restaurant_id]
    @comment = Comment.find(params[:id])
    @comment.update_attributes(params[:comment])
    respond_with(@comment)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_with(@comment)
  end
end
