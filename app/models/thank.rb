class Thank < ActiveRecord::Base
  validates_length_of :message, :maximum => 100, :message => "Message is too long (maximum is 100 characters)."

  belongs_to :from_user, :class_name => 'User', :foreign_key => 'from_user'
  belongs_to :to_user, :class_name => 'User', :foreign_key => 'to_user'

  before_save :assign_user_from_hash_tag
  before_save :validate_source_and_target_user

  scope :todays_thanks, where("created_at LIKE ?","#{Date.today.to_s}%")

  def user_in_message
    target_user = nil
    User.all.each do |user|
      target_user = user if self.message.include?(user.name) && (target_user.blank? || user.name.size > target_user.name.size)
    end
    target_user
  end

  private
  def validate_source_and_target_user
    return false if self.to_user == from_user
    self.to_user.gain_points!(2)
    gain_source_user_point_if_its_his_first_thanks_today

    true
  end

  def gain_source_user_point_if_its_his_first_thanks_today
    Thank.todays_thanks.each do |thank|
      return if thank.from_user == self.from_user
    end
    self.from_user.gain_points!(1)
  end

  def assign_user_from_hash_tag
    user = user_in_message
    return false if user.blank?

    self.to_user = user
    self.message.sub!(user.name, '')
  end
  
end
