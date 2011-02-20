class CompaniesController < ApplicationController
  before_filter :authenticate_user!, :only_admin
  respond_to :html

  def index
    respond_with(@companies = Company.all)
  end

  def show
    respond_with(@company = Company.find(params[:id]))
  end

  def new
    respond_with(@company = Company.new)
  end

  def edit
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.new(params[:company])

    if @company.save(params[:company])
      flash[:notice] = 'Company was successfully created.'
      redirect_to companies_path
    else
      render :action => "new"
    end
  end

  def update
    @company = Company.find(params[:id])

    if @company.update_attributes(params[:company])
      redirect_to(companies_path, :notice => 'Company was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    redirect_to(companies_url)
  end
end
