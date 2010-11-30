class ApplicationController < ActionController::Base
  protect_from_forgery  :except => [:create_thanks_from_iphone]
end
