require 'spec_helper'

describe ThanksController do

  def mock_thank(stubs={})
    @mock_thank ||= mock_model(Thank, stubs)
  end
  
  before(:each) do
    @user = Factory(:user)
    controller.stub(:current_user).and_return @user
  end

  describe "GET index" do
    it "assigns all thanks as @thanks" do
      Thank.stub(:all).and_return([mock_thank])

      get :index
      assigns[:thanks].should == [mock_thank]
    end
  end

  describe "GET show" do
    it "assigns the requested thank as @thank" do
      Thank.stub(:find).with("37").and_return(mock_thank)
      get :show, :id => "37"
      assigns[:thank].should equal(mock_thank)
    end
  end

  describe "GET new" do
    it "assigns a new thank as @thank" do
      Thank.stub(:new).and_return(mock_thank)
      get :new
      assigns[:thank].should equal(mock_thank)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created thank as @thank" do
        Thank.stub(:new).and_return(mock_thank(:save => true))
        post :create, :thank => {:these => 'params'}
        assigns[:thank].should equal(mock_thank)
      end

      it "redirects to the created thank" do
        Thank.stub(:new).and_return(mock_thank(:save => true))
        post :create, :thank => {}
        response.should redirect_to(root_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved thank as @thank" do
        mock_th = mock('thanks', :save => false, :errors => '')
        Thank.stub(:new).and_return(mock_th)
        post :create, :thank => {:these => 'params'}
        assigns[:thank].should equal(mock_th)
      end

      it "re-renders the 'new' template" do
        mock_th = mock('thanks', :save => false, :errors => '')
        Thank.stub(:new).and_return(mock_th)
        post :create, :thank => {}
        response.should redirect_to(root_url)
      end
    end

  end
end
