class User < ActiveRecord::Base

  validates_uniqueness_of :name
  validates_numericality_of :points

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :login, :password, :password_confirmation, :remember_me

  def gain_point!
    self.points += 1
    self.save!
  end

end