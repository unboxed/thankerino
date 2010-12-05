require 'spec_helper'

describe Group do
  it "has mandatory name" do
    group = Factory.build(:group, :name => '')
    group.save.should be_false
  end

  it "has many users" do
    user1 = Factory(:user)
    user2 = Factory(:user)
    group = Factory(:group, :name => 'first group', :users => [user1, user2])

    group.users.size.should == 2
    group.users.should include(user1, user2)
  end
end
