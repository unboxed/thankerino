class ThanksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @thanks = Thank.all
    @thank = Thank.new

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @thank = Thank.find(params[:id])

    respond_to do |format|
      format.html { redirect_to(root_url) }
    end
  end

  def new
    @thank = Thank.new
    respond_to do |format|
      format.html { redirect_to(root_url) }
    end
  end

  def create
    params[:thank].merge!(:from_user => current_user)
    @thank = Thank.new(params[:thank])

    respond_to do |format|
      if @thank.save
        flash[:notice] = "Thank you message created."
        # UserMailer.thanks_notice(@thank.to_user).deliver
        format.html { redirect_to(root_url) }
      else
        flash[:notice] = "Please type the name of target user and thank you message."
        format.html { redirect_to(root_url) }
      end
    end
  end
end
