require 'spec_helper'

describe UsersController do
  describe "show all" do
    it "return all users" do
      user1 = Factory(:user)
      user2 = Factory(:user)
      user3 = Factory(:user)

      get :index
      assigns[:users].size == 3
    end

    it "response in json" do
      user1 = Factory(:user)
      user2 = Factory(:user)
      user3 = Factory(:user)

      get :index, :format => 'json'
      users_json = JSON.parse(response.body)
      users_json.length.should == 3
    end
  end
end
