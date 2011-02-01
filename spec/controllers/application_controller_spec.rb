require 'spec_helper'

describe ApplicationController do
  describe "only_admin" do
    it "redirect to users profile page if logged user is not an admin" do
      user = mock('user',:is_admin? => false)
      controller.stub!(:current_user).and_return user
      controller.should_receive(:redirect_to).and_return true
      
      controller.only_admin
    end
  end
end
