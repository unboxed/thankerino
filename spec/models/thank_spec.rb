require 'spec_helper'

describe Thank do

  before(:each) do
    @to_user = Factory(:user, :login => 'Fantomas')
    @valid_attributes = {
      :message => "Fantomas is here.",
      :from_user => Factory(:user),
      :to_user => @to_user
    }
  end

  it "creates a new instance given valid attributes" do
    Thank.create!(@valid_attributes)
  end

  it "validate length of message to 100" do
    @valid_attributes.merge!(:message => "Space... the Final Frontier. These are the voyages of the starship Enterprise. Its continuing mission: to explore strange new worlds, to seek out new life and new civilizations, to boldly go where no one has gone before.")
    thank = Thank.new(@valid_attributes)

    thank.save.should == false
  end

  it "belongs to user_from and user_to" do
    from_user = Factory(:user)
    @valid_attributes.merge!(:from_user => from_user)

    thank = Thank.new(@valid_attributes)
    thank.save.should == true

    thank.to_user.should == @to_user
    thank.from_user.should == from_user
  end

  describe "find user by has tag(login) if" do
    before(:each) do
      @from_user = Factory(:user)
    end

    it "login is in standard format" do
      to_user = Factory(:user, :login => 'spock', :name => 'Mr. Spock')

      thank = Thank.create({:from_user => @from_user, :message => "spock We're rescuing you!"})
      thank.to_user.should == to_user
    end
  end
  
  it "doesn't save thanks from user 1 to user 1" do
    to_user = Factory(:user, :login => 'spock', :name => 'Mr. Spock')
    thank = Thank.new({:from_user => to_user, :message => "spock We're rescuing you!"})
    thank.save.should be_false
  end

  it "delete login from message" do
    from_user = Factory(:user)
    to_user = Factory(:user, :login => 'spock', :name => 'Mr. Spock')
    thank = Thank.create({:from_user => from_user, :message => "spock We're rescuing you!"})
    thank.message.should == " We're rescuing you!"
  end

  # it "increase points for user" do
  #   user = Factory(:user, :login => "mr.awsome")
  #   th1 = Factory(:thank, :user => user, :message => "mr.awsome you are great.")
  #   th2 = Factory(:thank, :user => user, :message => "mr.awsome you are the best.")
  # 
  #   User.find_by_id(user.id).points.should == 2
  # end

end
