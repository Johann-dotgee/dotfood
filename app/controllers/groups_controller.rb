class GroupsController < ApplicationController
  def index
    @groups = Group.all
    respond_with(@groups)
  end

  def show
    @group = Group.find(params[:id])
    respond_with(@group)
  end

  def new
    @group = Group.new
    respond_with(@group)
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(params[:group])
    @group.save
    respond_with(@group)
  end

  def update
    @group = Group.find(params[:id])
    @group.update_attributes(params[:group])
    respond_with(@group)
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    respond_with(@group)
  end
end
