# == Schema Information
#
# Table name: scoreboards
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  from_date  :date
#  to_date    :date
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer(4)
#

class Scoreboard < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :user_id

  belongs_to :user
end
