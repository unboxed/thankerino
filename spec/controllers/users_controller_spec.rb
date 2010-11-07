require 'spec_helper'

describe UsersController do
  before(:each) do
    user1 = Factory(:user, :name => 'Petr Parker', :points => 2)
    user2 = Factory(:user)
    user3 = Factory(:user)
    sign_in user1
  end

  describe "show all" do
    it "return all users" do
      get :index

      assigns[:users].size == 3
    end

    it "response in json" do
      get :index, :format => 'json'

      users_json = JSON.parse(response.body)
      users_json.length.should == 3
    end

    describe "users contains" do
      it "points" do
        get :index
        assigns[:users].first[:name].should == "Petr Parker"
      end

      it "name" do
        get :index
        assigns[:users].first[:points].should == 2
      end
    end

    describe "users doesn't contain" do
      it "password" do
        get :index
        assigns[:users].first[:password].should be_nil
      end

      it "email" do
        get :index
        assigns[:users].first[:email].should  be_nil
      end
    end
  end
end
