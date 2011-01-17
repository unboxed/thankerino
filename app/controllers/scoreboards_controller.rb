class ScoreboardsController < ApplicationController

  before_filter :authenticate_user!
  respond_to :html

  def index
    @scoreboards = Scoreboard.all
  end

  def new
    @scoreboard = Scoreboard.new
  end

  def edit
    @scoreboard = Scoreboard.find(params[:id])
  end

  def create
    @scoreboard = Scoreboard.new(params[:scoreboard])

    if @scoreboard.save
      redirect_to(@scoreboard, :notice => 'Scoreboard was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @scoreboard = Scoreboard.find(params[:id])

    if @scoreboard.update_attributes(params[:scoreboard])
     redirect_to(@scoreboard, :notice => 'Scoreboard was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @scoreboard = Scoreboard.find(params[:id])
    @scoreboard.destroy

    redirect_to(scoreboards_url)
  end
end
