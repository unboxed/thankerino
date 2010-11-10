require 'spec_helper'

describe ThanksController do

  def mock_thank(stubs={})
    @mock_thank ||= mock_model(Thank, stubs)
  end

  before(:each) do
    @user = Factory(:user)
    sign_in @user
    controller.stub(:current_user).and_return @user
  end

  describe "GET index" do
    it "assigns all thanks as @thanks" do
      Thank.stub(:all).and_return([mock_thank])

      get :index
      assigns[:thanks].should == [mock_thank]
    end

    it "assigns all thanks as @thanks" do
      Thank.stub(:all).and_return([mock_thank])

      get :index, :format => 'xml'
      assigns[:thanks].should == [mock_thank]
    end

    it "assigns all thanks to hash" do
      Factory(:user, :name => 'user 2')
      from_user = Factory(:user, :name => 'user 23')
      Factory(:thank, :created_at => Date.today.to_s(:db), :message => 'thanks to user 2 he is great1.', :from_user => from_user)
      Factory(:thank, :created_at => 1.day.ago, :message => 'thanks to user 2 he is great2.', :from_user => from_user)

      hash_thanks = controller.format_thanks
      hash_thanks.size.should == 2
      hash_thanks.first[:thank][:date].should == "2010-11-10"
      hash_thanks.first[:thank][:thankername].should == "user 23"
      hash_thanks.first[:thank][:thankedname].should == "user 2"
      hash_thanks.first[:thank][:text].should == "thanks to  he is great1."
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
        Thank.stub(:new).and_return(mock_thank(:save => true, :to_user => mock('User', :email => 'mail')))
        post :create, :thank => {:these => 'params'}
        assigns[:thank].should equal(mock_thank)
      end

      it "redirects to the created thank" do
        Thank.stub(:new).and_return(mock_thank(:save => true, :to_user => mock('User', :email => 'mail')))
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
