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
end
