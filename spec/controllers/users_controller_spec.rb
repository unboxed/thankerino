require 'spec_helper'

describe UsersController do
  before(:each) do
    user1 = Factory(:user, :name => 'Petr Parker', :points => 2)
    user2 = Factory(:user)
    user3 = Factory(:user)
    sign_in user1
  end

  describe "POST create" do
    it "assing newly created user to @user" do
      user = mock('mock_user', {:name => 'superman', :email => 'clark@kent.com', :save => true})
      controller.stub(:redirect_back_or_default).and_return true
      controller.should_receive(:generate_password).with('clark@kent.com').and_return 'abcd123'
      User.stub(:new).with({"name"=>"superman", "password"=>"abcd123", "login"=>"clark@kent.com", "email"=>"clark@kent.com"}).and_return user

      post :create, :user => {:name => 'superman', :email => 'clark@kent.com'}
      assigns(:user).should == user
    end

    it "redirect to the administration page if the result user is saved" do
      user = mock('mock_user', {:name => 'superman', :email => 'clark@kent.com', :save => true})
      # UserMailer.stub(:register_email).and_return mock('mailer', :deliver => true)
      controller.stub(:redirect_back_or_default).and_return true
      controller.should_receive(:generate_password).with('clark@kent.com').and_return 'abcd123'
      User.stub(:new).with({"name"=>"superman", "password"=>"abcd123", "login"=>"clark@kent.com", "email"=>"clark@kent.com"}).and_return user

      post :create, :user => {:name => 'superman', :email => 'clark@kent.com'}
      response.should redirect_to(new_import_url)
    end

    it "redirect to the administration page if the result user is not saved" do
      user = mock('mock_user', {:name => 'superman', :email => 'clark@kent.com', :save => false})
      controller.stub(:redirect_back_or_default).and_return true
      controller.should_receive(:generate_password).with('clark@kent.com').and_return 'abcd123'
      User.stub(:new).with({"name"=>"superman", "password"=>"abcd123", "login"=>"clark@kent.com", "email"=>"clark@kent.com"}).and_return user

      post :create, :user => {:name => 'superman', :email => 'clark@kent.com'}
      response.should redirect_to(new_import_url)
    end

    it "generate password for the new user" do
      user = mock('mock_user', {:name => 'superman', :email => 'clark@kent.com', :save => false})
      controller.stub(:redirect_back_or_default).and_return true

      controller.should_receive(:generate_password).with('clark@kent.com').and_return 'abcd123'
      User.stub(:new).with({"name" => 'superman', "email" => 'clark@kent.com', "password" => 'abcd123', "login" => 'clark@kent.com'}).and_return user

      post :create, :user => {:name => 'superman', :email => 'clark@kent.com'}
      assigns(:user).should == user
    end

    it "send an email after successful registration" do
      user = mock('mock_user', {:name => 'superman', :email => 'clark@kent.com', :save => true})
      mailer = mock('user_mailer')
      controller.stub(:redirect_back_or_default).and_return true

      controller.should_receive(:generate_password).with('clark@kent.com').and_return 'abcd123'
      mailer.should_receive(:deliver).and_return true
      User.stub(:new).with({"name" => 'superman', "email" => 'clark@kent.com', "password" => 'abcd123', "login" => 'clark@kent.com'}).and_return user
      UserMailer.should_receive(:register_email).with(user, 'abcd123').and_return mailer

      post :create, :user => {:name => 'superman', :email => 'clark@kent.com'}
      assigns(:user).should == user
    end
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

    it "response in json is merged with groups" do
      Group.should_receive(:order).with("name ASC").and_return mock('group', :map => {:name => 'group1'})
      User.stub(:order).and_return []

      get :index, :format => 'json'
      assigns[:users].should == [{"name"=>"group1"}]
    end

    it "format_users for xml" do
      User.delete_all
      user1 = Factory(:user, :name => 'Petr Parker2', :points => 20)
      user2 = Factory(:user, :name => 'Superman', :points => 33)

      hash_users = controller.format_users
      hash_users.size.should == 2

      hash_users.first[:id].should == user1.id
      hash_users.first[:name].should == user1.name
      hash_users.first[:points].should == user1.points

      hash_users.last[:id].should == user2.id
      hash_users.last[:name].should == user2.name
      hash_users.last[:points].should == user2.points
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

    describe "UPDATE" do
      it "with valid params redirect to user detail" do
        user = mock('mock_user')
        controller.stub(:current_user).and_return user
        user.should_receive(:update_attributes).with({'these' => 'params'}).and_return true

        put :update, :id => "1", :user => {'these' => 'params'}
        response.should redirect_to(user_url(user))
      end

      it "with valid params update only non empty values" do
        user = mock('mock_user')
        controller.stub(:current_user).and_return user
        user.should_receive(:update_attributes).with({"these"=>"params", "another params"=>"values"}).and_return true

        put :update, :id => "1", :user => {'these' => 'params', 'empty' => '', 'another params' => 'values'}
        response.should redirect_to(user_url(user))
      end

      it "with invalid params render edit template" do
        user = mock('mock_user')
        controller.stub(:current_user).and_return user
        user.should_receive(:update_attributes).and_return false

        put :update, :id => "1", :user => {'these' => 'params'}
        response.should render_template("edit")
      end

    end
  end
end
