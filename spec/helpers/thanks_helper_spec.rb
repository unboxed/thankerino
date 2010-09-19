require 'spec_helper'

describe ThanksHelper do
  # include ThanksHelper
  it "return name of target_user user" do
    to_user = Factory(:user, :name => 'Clark Kent', :login => 'clark')
    thanks = Factory(:thank, :message => 'clark is Superman')

    target_user(thanks).should == 'Clark Kent'
  end

  it "return login of target_user user if name is empty" do
    to_user = Factory(:user, :name => '', :login => 'clark')
    thanks = Factory(:thank, :message => 'clark is Superman')

    target_user(thanks).should == 'clark'
  end

end
