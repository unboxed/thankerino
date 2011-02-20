# == Schema Information
#
# Table name: companies
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Company do
  it "has mandatory name" do
    cmp = Factory.build(:company, :name => "")
    cmp.save.should == false
  end

  it "has uniq name" do
    cmp1 = Factory(:company, :name => "ubxd")
    cmp2 = Factory.build(:company, :name => "ubxd")
    cmp2.save.should == false
  end

  it "is public as default" do
    cmp = Factory(:company)
    cmp.is_public.should == true
  end

  it "has many users" do
    user1 = Factory(:user)
    user2 = Factory(:user)
    cmp = Factory(:company, :users => [user1, user2])
    cmp.users.should include(user1, user2)
  end
end
