class VotesController < ApplicationController
  # GET /votes
  # GET /votes.xml
  def index
    @votes = Vote.all
    respond_with(@votes)
  end

  # GET /votes/1
  # GET /votes/1.xml
  def show
    @vote = Vote.find(params[:id])
    respond_with(@vote)
  end

  # GET /votes/new
  # GET /votes/new.xml
  def new votable_id, votable_type, voter_id, voter_type, vote_flag
    require "date"
    @vote = Vote.new('', votable_id, votable_type, voter_id, voter_type, vote_flag, Date.today, Date.today)
    @vote.save
    respond_with(@vote)
  end

  # GET /votes/1/edit
  def edit
    @vote = Vote.find(params[:id])
  end

  # POST /votes
  # POST /votes.xml
  def create
    @vote = Vote.new(params[:vote])
    @vote.save
    respond_with(@vote)
  end

  # PUT /votes/1
  # PUT /votes/1.xml
  def update
    @vote = Vote.find(params[:id])
    @vote.update_attributes(params[:vote])
    respond_with(@vote)
  end

  # DELETE /votes/1
  # DELETE /votes/1.xml
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy
    respond_with(@vote)
  end
end
