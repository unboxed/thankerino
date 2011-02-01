class AdministrationController < ApplicationController
  before_filter :authenticate_user!, :only_admin

  respond_to :html

  def index
  end

  def destroy
    flash[:notice] = (User.reset_points) ? "All points deleted." : "Points were not reseted, contact administrator."
    redirect_to admin_url
  end
end
