require 'spec_helper'

describe AdministrationController do
  before(:each) do
    controller.stub!(:authenticate_user!).and_return true
  end

  it "redirect to users profile page if logged user is not an admin" do
    user = mock('user',:is_admin? => false)
    controller.stub!(:current_user).and_return user

    get :index
    response.should redirect_to(user_url(user))
  end

  describe "index" do
    it "render admin index page" do
      user = mock('user',:is_admin? => true)
      controller.stub!(:current_user).and_return user

      get :index
      response.should render_template("index")
    end
  end
end
