class User < ActiveRecord::Base
  acts_as_authentic
  # acts_as_authentic do |config|
  #   config.validate_email_field false
  #   # for available options see documentation in: Authlogic::ActsAsAuthentic
  # end
end