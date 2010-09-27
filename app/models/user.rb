class User < ActiveRecord::Base
  acts_as_authentic
  # acts_as_authentic do |config|
  #   config.validate_email_field false
  #   # for available options see documentation in: Authlogic::ActsAsAuthentic
  # end

  validates_numericality_of :points
  validates_uniqueness_of :name

  def gain_point!
    self.points += 1
    self.save!
  end
end