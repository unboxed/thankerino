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

    it "format_users for xml" do
      User.delete_all
      user1 = Factory(:user, :name => 'Petr Parker2')
      user2 = Factory(:user, :name => 'Superman')

      hash_users = controller.format_users
      hash_users.size.should == 2

      hash_users.first[:id].should == user1.id
      hash_users.first[:name].should == user1.name

      hash_users.last[:id].should == user2.id
      hash_users.last[:name].should == user2.name
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

      it "avatar" do
        get :index
        assigns[:users].first[:avatar].should == '/avatars/list/missing.png'
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
