require 'spec_helper'

describe ThanksHelper do
  # include ThanksHelper
  it "return name of target_user user" do
    to_user = Factory(:user, :name => 'Clark Kent')
    thanks = Factory(:thank, :message => 'Clark Kent is Superman')

    target_user(thanks).should == 'Clark Kent'
  end

  it "return login of target_user user if name is empty" do
    to_user = Factory(:user, :name => '', :login => 'clark')
    thanks = Factory(:thank, :message => 'clark is Superman')

    target_user(thanks).should == 'clark'
  end

  it "return all thanks message for target_user" do
    to_user = Factory(:user, :name => 'Clark Kent')
    thanks1 = Factory(:thank, :message => 'Clark Kent is Superman', :to_user => to_user )
    thanks2 = Factory(:thank, :message => 'Clark Kent is Superman2')
    thanks3 = Factory(:thank, :message => 'Clark Kent is Superman3')
    thanks_for_user(to_user).should include(thanks1)
  end

  it "return all thanks message for target_user" do
    to_user = Factory(:user, :name => 'Clark Kent')

    thanks_for_user(to_user).should == []
  end

end
