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
#

require 'spec_helper'

describe Scoreboard do
  it "has mandatory name" do
    sc = Factory.build(:scoreboard, :name => "")
    sc.save.should == false
  end

  it "has mandatory user_id" do
    sc = Factory.build(:scoreboard, :name => "monthly winer", :user => nil)
    sc.save.should == false
  end

  it "has one user" do
    user = Factory(:user)
    sc = Factory(:scoreboard, :user => user)
    sc.user.should == user
  end

end
