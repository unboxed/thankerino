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

  it "increase points by one" do
    user = Factory(:user, :points => 0)
    user.gain_point!
    user.points.should == 1
  end
end
