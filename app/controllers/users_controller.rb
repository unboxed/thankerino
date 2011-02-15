class UsersController < ApplicationController
  include UsersHelper

  before_filter :authenticate_user!, :except => [:new, :create]
  respond_to :html, :except => :index

  def index
    groups = Group.order("name ASC").map { |group| {:name => group.name} }
    @users = User.order("points DESC").map do |user|
      {:name => user.name, :points => user.points, :user_id => user.id, :avatar => user.avatar(:list)}
    end

    @users << groups
    @users.flatten!
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
    user = params[:user]
    password = generate_password(user['email']) if user['email'].present?
    user.merge!({:password => password, :login => user['email']})
    @user = User.new(user)

    if @user.save
      flash[:notice] = "User created!"
      UserMailer.register_email(@user, password).deliver
      redirect_to new_import_url
    else
      redirect_to new_import_url
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
    params[:user].delete_if {|key, value| value == ""}
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to user_url(@user)
    else
      render :action => :edit
    end
  end

  def format_users
    User.find(:all).map do |user|
      {:id => user.id, :name => user.name, :points => user.points}
    end
  end
end
