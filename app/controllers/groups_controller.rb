class GroupsController < ApplicationController
  before_filter :authenticate_user!, :only_admin

  def index
    @groups = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end

  def new
    @group = Group.new
    @users = User.order("name ASC")

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group }
    end
  end

  def edit
    @group = Group.find(params[:id])
    @users = User.order("name ASC")
  end

  def create
    if params[:user].blank?
      users = []
    else
      users = params[:user].map {|u| User.find(u.first)}
    end

    params[:group][:users] = users
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        format.html { redirect_to(groups_url, :notice => 'Group was successfully created.') }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        @users = User.order("name ASC")
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    if params[:user].blank?
      users = []
    else
      users = params[:user].map {|u| User.find(u.first)}
    end
    params[:group][:users] = users
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to(groups_url, :notice => 'Group was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url) }
      format.xml  { head :ok }
    end
  end
end
