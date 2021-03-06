# == Schema Information
#
# Table name: users
#
#  id                   :integer(4)      not null, primary key
#  name                 :string(255)
#  login                :string(255)
#  email                :string(255)     not null
#  encrypted_password   :string(128)     not null
#  password_salt        :string(255)     not null
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
#  role                 :integer(4)      default(0)
#  company_id           :integer(4)      default(0)
#

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

  it "validate uniqueness of email" do
    Factory(:user, :email => "12@34.com")
    user = Factory.build(:user, :email => "12@34.com")
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

  it "has got role" do
    user = Factory(:user, :role => User::ROLE[:admin])
    user.role.should == User::ROLE[:admin]
  end

  describe "ROLE constant" do
    it "has admin role" do
      User::ROLE[:admin].should == 1
    end

    it "has employee role" do
      User::ROLE[:employee].should == 0
    end
  end

  describe "is_admin?" do
    it "return true if user is admin" do
      user = Factory(:user, :role => User::ROLE[:admin])
      user.is_admin?.should be_true
    end

    it "return true if user is admin" do
      user = Factory(:user)
      user.is_admin?.should be_false
    end
  end

  it "has many groups" do
    group1 = Factory(:group)
    group2 = Factory(:group)
    user = Factory(:user, :groups => [group1, group2])

    user.groups.size.should == 2
    user.groups.should include(group1, group2)
  end

  describe "reset_points" do
    it "get all user and assign them 0 points" do
      user = mock('user_mock', :save => true)
      user.should_receive(:points=).with(0).and_return true
      User.stub(:find).with(:all).and_return [user]

      User.reset_points.should == true
    end

    it "return false is something went wrong" do
      user = mock('user_mock', :save => false)
      user.should_receive(:points=).with(0).and_return true
      User.stub(:find).with(:all).and_return [user]

      User.reset_points.should == false
    end
  end

  it "has many scoreboards" do
    user = Factory(:user)
    user.scoreboards.should == []
  end

  it "has many assigned scoreboards" do
    sc1 = Factory(:scoreboard)
    sc2 = Factory(:scoreboard)
    sc3 = Factory(:scoreboard)

    user = Factory(:user, :scoreboards => [sc1,sc2,sc3])
    user.scoreboards.should include(sc1,sc2,sc3)
  end

  it "has company" do
    company = Factory(:company)
    user = Factory(:user, :company => company)
    user.company.should == company
  end
end
