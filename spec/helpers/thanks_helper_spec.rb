require 'spec_helper'

describe ThanksHelper do
  # include ThanksHelper
  describe "target_user" do
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
  end

  describe "source_user" do
    before(:each) do
      Factory(:user, :name => 'Clark Kent')
    end

    it "return name of target_user user" do
      from_user = Factory(:user, :name => 'Petr Zaparka')
      thanks = Factory(:thank, :message => 'Clark Kent is Superman', :from_user => from_user)

      source_user(thanks).should == 'Petr Zaparka'
    end
    
    it "return login of source_user user if name is empty" do
      from_user = Factory(:user, :name => '', :login => 'petr')
      thanks = Factory(:thank, :message => 'Clark Kent is Superman', :from_user => from_user)

      source_user(thanks).should == 'petr'
    end
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
