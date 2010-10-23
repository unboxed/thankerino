class UsersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    @users = User.all
    respond_with(@users)
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
end
