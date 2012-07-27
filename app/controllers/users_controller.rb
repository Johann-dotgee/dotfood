#encoding:utf-8
class UsersController < ApplicationController

  def index
    @users = User.all(:include => [:roles])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    if current_user.has_role? :admin
      @user = User.find(params[:id])
    else
      flash[:error] = "Vous n'avez pas les droits nécessaires pour accéder à cette page"
      redirect_to users_path
    end
  end

  def groupes
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    if current_user.has_role? :admin
      @user = User.find(params[:id])
      @user.update_attributes(params[:user])
      respond_with(@user)
    else
      flash[:error] = "Vous n'avez pas les droits nécessaires pour accéder à cette page"
      redirect_to users_path
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    if current_user.has_role? :admin
      @user = User.find(params[:id])
      @user.destroy
      respond_with(@user)
    else
      flash[:error] = "Vous n'avez pas les droits nécessaires pour accéder à cette page"
      redirect_to users_path
    end
  end

  def add_role
    if current_user.has_role? :admin
      @user = User.find(params[:id])
      @user.add_role :admin
      flash[:notice] = "Modification effectuée"
      redirect_to users_path
    else
      flash[:error] = "Vous n'avez pas les droits nécessaires pour accéder à cette page"
      redirect_to users_path
    end
  end

  def change_role
    if current_user.has_role? :admin
      @user = User.find(params[:id])
      @user.remove_role :admin
      flash[:notice] = "Modification effectuée"
      redirect_to users_path
    else
      flash[:error] = "Vous n'avez pas les droits nécessaires pour accéder à cette page"
      redirect_to users_path
    end
  end

  def eat_alone
    @alone = EatAlone.new
    @alone.eat_alone = true
    @alone.user_id = params[:id]
    conditions = {:updated_at => Date.today}
    votes = current_user.find_votes conditions
    votes.each do |vote|
      vote.destroy
    end
    if EatAlone.find(:all, :conditions => ["user_id=? AND created_at=?", params[:id], Date.today]).blank?
      @alone.save
    else
      flash[:error] = "Vous avez déjà indiqué que vous ne désirez pas manger avec les autres"
    end
    redirect_to dashboard_restaurants_path
  end

end