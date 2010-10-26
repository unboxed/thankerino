class User < ActiveRecord::Base

  validates_uniqueness_of :name
  validates_numericality_of :points

  has_many :thanks, :foreign_key => 'from_user'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :login, :password, :password_confirmation, :remember_me

  def gain_points!(number)
    self.points += number
    self.save!
  end

  def lose_points!(number)
    self.points -= number
    self.save!
  end

end