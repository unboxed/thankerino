class ApplicationController < ActionController::Base
  protect_from_forgery  :except => [:create_thanks_from_iphone]

  def only_admin
    redirect_to(user_url(current_user)) unless current_user.is_admin?
  end
end
