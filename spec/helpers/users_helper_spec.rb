require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersHelper do

  describe "generate_password" do
    it "which is at least 6 chars long" do
      helper.generate_password('someemail').size.should > 5
    end

    it "which include at least one digit" do
      helper.stub(:rand).and_return 82
      helper.generate_password('someemail').should include("82")
    end

    it "without double quoting chars" do
      helper.generate_password('"""""""""""').should_not include('"')
    end

    it "without simple quoting chars" do
      helper.generate_password("'''''''''''''").should_not include("'")
    end
  end
end
