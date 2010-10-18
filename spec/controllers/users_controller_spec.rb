require 'spec_helper'

describe UsersController do
  before(:each) do
    user1 = Factory(:user)
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
  end
end
