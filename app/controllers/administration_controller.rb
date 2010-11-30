class AdministrationController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def index
    redirect_to(user_url(current_user)) unless current_user.is_admin?
  end
end
