# == Schema Information
#
# Table name: users
#
#  id                   :integer(4)      not null, primary key
#  name                 :string(255)
#  login                :string(255)
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer(4)      default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  points               :integer(4)      default(0)
#  avatar_file_name     :string(255)
#  avatar_content_type  :string(255)
#  avatar_file_size     :integer(4)
#  avatar_updated_at    :datetime
#

class User < ActiveRecord::Base

  validates_uniqueness_of :name
  validates_numericality_of :points

  has_many :thanks, :foreign_key => 'from_user'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :login, :password, :password_confirmation, :remember_me, :avatar

  has_attached_file :avatar, :styles => { :profile => "65x65", :list => "40x40"},
    :storage => :s3, :s3_credentials => "#{Rails.root}/config/s3.yml", :path => ":attachment/:id/:style.:extension",
    :url => ":s3_domain_url"

  def gain_points!(number)
    self.points += number
    self.save!
  end

  def lose_points!(number)
    self.points -= number
    self.save!
  end

end
