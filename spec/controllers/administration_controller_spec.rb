require 'spec_helper'

describe AdministrationController do
  before(:each) do
    controller.stub!(:authenticate_user!).and_return true
    controller.stub!(:only_admin).and_return true
  end

  describe "before filters" do
    it "shoult authenticate type of user" do
      controller.should_receive(:only_admin).and_return true
      get :index
    end
  end

  describe "index" do
    it "render admin index page" do
      user = mock('user',:is_admin? => true)
      controller.stub!(:current_user).and_return user

      get :index
      response.should render_template("index")
    end
  end

  describe "destroy" do
    it "reset points for everyone" do
      User.should_receive(:reset_points).and_return true

      get :destroy
      response.should redirect_to(admin_url)
      flash[:notice].should == "All points deleted."
    end

    it "render err message points for everyone" do
      User.should_receive(:reset_points).and_return false

      get :destroy
      flash[:notice].should == "Points were not reseted, contact administrator."
    end
  end

end
