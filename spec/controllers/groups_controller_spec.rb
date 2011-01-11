require 'spec_helper'

describe GroupsController do

  def mock_group(stubs={})
    (@mock_group ||= mock_model(Group).as_null_object).tap do |group|
      group.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all groups as @groups" do
      Group.stub(:all) { [mock_group] }
      get :index
      assigns(:groups).should eq([mock_group])
    end
  end

  describe "GET new" do
    it "assigns a new group as @group" do
      Group.stub(:new) { mock_group }
      get :new
      assigns(:group).should be(mock_group)
    end

    it "assigns all users as @users ordered by name ASC" do
      Group.stub(:new) { mock_group }
      User.should_receive(:order).with("name ASC").and_return []

      get :new
      assigns(:users).should == []
    end

  end

  describe "GET edit" do
    it "assigns the requested group as @group" do
      Group.stub(:find).with("37") { mock_group }
      get :edit, :id => "37"
      assigns(:group).should be(mock_group)
    end

    it "assigns all users as @users ordered by name ASC" do
      User.should_receive(:order).with("name ASC").and_return []
      Group.stub(:find).with("37") { mock_group }

      get :edit, :id => "37"
      assigns(:users).should == []
    end
    
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created group as @group" do
        Group.stub(:new).with({'these' => 'params', "users"=>[]}) { mock_group(:save => true) }
        post :create, :group => {'these' => 'params'}
        assigns(:group).should be(mock_group)
      end

      it "create users array filled with users from params" do
        user_1 = mock('user_1')
        user_2 = mock('user_2')
        User.should_receive(:find).with("31").and_return user_1
        User.should_receive(:find).with("32").and_return user_2
        Group.stub(:new).with({'these' => 'params', "users"=>[user_1, user_2]}) { mock_group(:save => true) }

        post :create, :group => {'these' => 'params'}, :user => {"31"=>"petr.zaparka@ubxd.com", "32"=>"tom.danger@ubxd.com"}
      end

      it "redirects to the created group" do
        Group.stub(:new) { mock_group(:save => true) }
        post :create, :group => {}
        response.should redirect_to(groups_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved group as @group" do
        Group.stub(:new).with({'these' => 'params', "users"=>[]}) { mock_group(:save => false) }
        post :create, :group => {'these' => 'params'}
        assigns(:group).should be(mock_group)
      end

      it "re-renders the 'new' template" do
        Group.stub(:new) { mock_group(:save => false) }
        post :create, :group => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested group" do
        Group.should_receive(:find).with("37") { mock_group }
        mock_group.should_receive(:update_attributes).with({'these' => 'params', "users"=>[]})
        put :update, :id => "37", :group => {'these' => 'params'}
      end

      it "assigns the requested group as @group" do
        Group.stub(:find) { mock_group(:update_attributes => true) }

        put :update, :id => "1", :group => {'these' => 'params'}
        assigns(:group).should be(mock_group)
      end

      it "redirects to the group" do
        Group.stub(:find) { mock_group(:update_attributes => true) }
        put :update, :id => "1", :group => {'these' => 'params'}
        response.should redirect_to(groups_url)
      end

      it "create users array filled with users from params" do
        user_1 = mock('user_1')
        user_2 = mock('user_2')
        User.should_receive(:find).with("31").and_return user_1
        User.should_receive(:find).with("32").and_return user_2
        mocked_group = mock('mocked_group')
        mocked_group.should_receive(:update_attributes).with({'these' => 'params', "users"=>[user_1, user_2]})
        Group.stub(:find).with("1") { mocked_group }

        put :update, :id => "1", :group => {'these' => 'params'}, :user => {"31"=>"petr.zaparka@ubxd.com", "32"=>"tom.danger@ubxd.com"}
      end
    end

    describe "with invalid params" do
      it "assigns the group as @group" do
        Group.stub(:find) { mock_group(:update_attributes => false) }
        put :update, :id => "1", :group => {'these' => 'params'}
        assigns(:group).should be(mock_group)
      end

      it "re-renders the 'edit' template" do
        Group.stub(:find) { mock_group(:update_attributes => false) }
        put :update, :id => "1", :group => {'these' => 'params'}
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested group" do
      Group.should_receive(:find).with("37") { mock_group }
      mock_group.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the groups list" do
      Group.stub(:find) { mock_group }
      delete :destroy, :id => "1"
      response.should redirect_to(groups_url)
    end
  end

end
