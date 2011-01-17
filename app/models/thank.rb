# == Schema Information
#
# Table name: thanks
#
#  id           :integer(4)      not null, primary key
#  message      :string(255)     not null
#  from_user    :integer(4)
#  to_user      :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#  group_thanks :boolean(1)      default(FALSE)
#

class Thank < ActiveRecord::Base
  validates_length_of :message, :maximum => 100, :message => "Message is too long (maximum is 100 characters)."

  belongs_to :from_user, :class_name => 'User', :foreign_key => 'from_user'
  belongs_to :to_user, :class_name => 'User', :foreign_key => 'to_user'

  before_save :assign_user_from_hash_tag
  before_save :validate_source_and_target_user

  scope :todays_thanks, {:conditions => ["created_at >= ?", Date.today]}
  scope :thanks_from,  lambda {|from| {:conditions => ["created_at >= ?", from] } }
  scope :from_user, lambda {|user| where(:from_user => user.id) }
  scope :to_user, lambda {|user| where(:to_user => user.id) }

  def user_in_message
    target_user = nil

    User.all.each do |user|
      target_user = user if self.message.include?(user.name) && (target_user.blank? || user.name.size > target_user.name.size)
    end
    return target_user if target_user.present?

    Group.all.each do |group|
      return group if self.message.include?(group.name)
    end

    target_user
  end

  private
  def validate_source_and_target_user
    return false if self.to_user == from_user
    self.to_user.gain_points!(2)
    gain_source_user_point_if_its_his_first_thanks_today if self.group_thanks == false

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
    return false if user.blank? || user.is_a?(Array)

    self.to_user = user
    self.message.sub!(user.name, '')
  end

end
