require 'spec_helper'

describe Thank do

  before(:each) do
    @to_user = Factory(:user, :login => 'Fantomas')
    @valid_attributes = {
      :message => "#Fantomas is here.",
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

  it "save message without #prefix " do
    @valid_attributes.merge!(:message => "##{@to_user.login} is comming.")
    thank = Thank.create(@valid_attributes)

    thank.message.should == " is comming."
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

      thank = Thank.create({:from_user => @from_user, :message => "Shut-up, #spock! We're rescuing you!"})
      thank.to_user.should == to_user
    end

    it "login contain dots" do
      to_user = Factory(:user, :login => 'mr.spock.a', :name => 'Mr. Spock')

      thank = Thank.create({:from_user => @from_user, :message => "Shut-up, #mr.spock.a! We're rescuing you!"})
      thank.to_user.should == to_user
    end

    it "login contain numbers" do
      to_user = Factory(:user, :login => 'spock1', :name => 'Mr. Spock')

      thank = Thank.create({:from_user => @from_user, :message => "Shut-up, #spock1! We're rescuing you!"})
      thank.to_user.should == to_user
    end
  end

  # it "increase points for user" do
  #   user = Factory(:user, :email => "mr.awsome@unboxedconsulting.com")
  #   th1 = Factory(:thank, :user => user, :message => "Thanks #mr.awsome, you are great.")
  #   th2 = Factory(:thank, :user => user, :message => "Thanks #mr.awsome, you are the best.")
  # 
  #   User.find_by_id(user.id).points.should == 2
  # end

end
