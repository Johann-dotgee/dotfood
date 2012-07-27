#encoding:utf-8
class EventsController < ApplicationController
  before_filter :load_group
  def index
    @events = @group.events
    respond_with(@group, @events)
  end

  def show
    @event = @group.events.where(id: params[:id])
    if @event.blank?
      flash[:error] = "Événement introuvable"
      redirect_to group_events_path(@group)
    else
      respond_with(@group, @event)
    end
  end

  def new
    @event = Event.new
    respond_with(@group, @event)
  end

  def edit
    @event = @group.events.where(id: params[:id]).first
    if @event.blank?
      flash[:error] = "Événement introuvable"
      redirect_to group_events_path(@group)
    end
  end

  def create
    @event = Event.new(params[:event])
    @event.group_id = params[:group_id]
    @event.save
    respond_with(@group, @event)
  end

  def update
    @event = @group.events.where(id: params[:id]).first
    if @event.blank?
      flash[:error] = "Événement introuvable"
      redirect_to group_events_path(@group)
    else
      @event.update_attributes(params[:event])
      respond_with(@group, @event)
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    respond_with(@group, @event)
  end

  private
    def load_group
      @group = Group.find(params[:group_id])
    end
end
