class Thank < ActiveRecord::Base
  validates_length_of :message, :maximum => 100, :message => "Message is too long (maximum is 100 characters)."

  belongs_to :from_user, :class_name => 'User', :foreign_key => 'from_user'
  belongs_to :to_user, :class_name => 'User', :foreign_key => 'to_user'

  before_save :assign_user_from_hash_tag

  private
  def assign_user_from_hash_tag
    name = /\#[\w\.]+/.match(self.message).to_s.sub('#','')
    return false if name.blank?

    user = User.where(:login => name)
    return false if user.blank?

    self.to_user = user.first
    self.message.gsub!(/\#[\w\.]+/, '')
  end
end
