require 'spec_helper'

describe User do
  describe "points" do
    it "save only if the value is number" do
      user = Factory.build(:user, :points => 2)
      user.save.should be_true
    end

    it "fail if the value is not number" do
      user = Factory.build(:user, :points => "s")
      user.save.should be_false
    end
  end

  it "validate uniqueness of name" do
    Factory(:user, :name => "New name")
    user = Factory.build(:user, :name => "New name")
    user.save.should be_false
  end

  it "increase points by x points" do
    user = Factory(:user, :points => 0)
    user.gain_points!(2)
    user.points.should == 2
  end

  it "decrease points by x points" do
    user = Factory(:user, :points => 3)
    user.lose_points!(2)
    user.points.should == 1
  end

end
