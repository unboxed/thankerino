# == Schema Information
#
# Table name: groups
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Group < ActiveRecord::Base
  validates_presence_of :name

  has_and_belongs_to_many :users
end
