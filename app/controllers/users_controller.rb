class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create]
  respond_to :html, :except => :index

  def index
    @users = User.find(:all, :order => "points DESC").map do |user|
      {:name => user.name, :points => user.points, :user_id => user.id, :avatar => user.avatar(:list)}
    end

    respond_to do |format|
      format.html
      format.json { render :json => @users}
      format.xml { render :xml => {:users => format_users} }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default user_url(@user)
    else
      render :action => :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to user_url(@user)
    else
      render :action => :edit
    end
  end

  def format_users
    User.find(:all).map do |user|
      {:id => user.id, :name => user.name}
    end
  end
end
