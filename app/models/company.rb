# == Schema Information
#
# Table name: companies
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Company < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :users
end
