require 'spec_helper'

describe ScoreboardsController do
  before(:each) do
    @user = Factory(:user)
    sign_in @user
    controller.stub(:current_user).and_return @user
  end

  def mock_scoreboard(stubs={})
    (@mock_scoreboard ||= mock_model(Scoreboard).as_null_object).tap do |scoreboard|
      scoreboard.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all scoreboards as @scoreboards" do
      Scoreboard.stub(:all) { [mock_scoreboard] }
      get :index
      assigns(:scoreboards).should eq([mock_scoreboard])
    end
  end

  describe "GET new" do
    it "assigns a new scoreboard as @scoreboard" do
      Scoreboard.stub(:new) { mock_scoreboard }
      get :new
      assigns(:scoreboard).should be(mock_scoreboard)
    end
  end

  describe "GET edit" do
    it "assigns the requested scoreboard as @scoreboard" do
      Scoreboard.stub(:find).with("37") { mock_scoreboard }
      get :edit, :id => "37"
      assigns(:scoreboard).should be(mock_scoreboard)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created scoreboard as @scoreboard" do
        Scoreboard.stub(:new).with({'these' => 'params'}) { mock_scoreboard(:save => true) }
        post :create, :scoreboard => {'these' => 'params'}
        assigns(:scoreboard).should be(mock_scoreboard)
      end

      it "redirects to the created scoreboard" do
        Scoreboard.stub(:new) { mock_scoreboard(:save => true) }
        post :create, :scoreboard => {}
        response.should redirect_to(scoreboard_url(mock_scoreboard))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved scoreboard as @scoreboard" do
        Scoreboard.stub(:new).with({'these' => 'params'}) { mock_scoreboard(:save => false) }
        post :create, :scoreboard => {'these' => 'params'}
        assigns(:scoreboard).should be(mock_scoreboard)
      end

      it "re-renders the 'new' template" do
        Scoreboard.stub(:new) { mock_scoreboard(:save => false) }
        post :create, :scoreboard => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested scoreboard" do
        Scoreboard.should_receive(:find).with("37") { mock_scoreboard }
        mock_scoreboard.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :scoreboard => {'these' => 'params'}
      end

      it "assigns the requested scoreboard as @scoreboard" do
        Scoreboard.stub(:find) { mock_scoreboard(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:scoreboard).should be(mock_scoreboard)
      end

      it "redirects to the scoreboard" do
        Scoreboard.stub(:find) { mock_scoreboard(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(scoreboard_url(mock_scoreboard))
      end
    end

    describe "with invalid params" do
      it "assigns the scoreboard as @scoreboard" do
        Scoreboard.stub(:find) { mock_scoreboard(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:scoreboard).should be(mock_scoreboard)
      end

      it "re-renders the 'edit' template" do
        Scoreboard.stub(:find) { mock_scoreboard(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested scoreboard" do
      Scoreboard.should_receive(:find).with("37") { mock_scoreboard }
      mock_scoreboard.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the scoreboards list" do
      Scoreboard.stub(:find) { mock_scoreboard }
      delete :destroy, :id => "1"
      response.should redirect_to(scoreboards_url)
    end
  end

end
