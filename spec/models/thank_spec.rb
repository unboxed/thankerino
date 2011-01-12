# == Schema Information
#
# Table name: thanks
#
#  id         :integer(4)      not null, primary key
#  message    :string(255)     not null
#  from_user  :integer(4)
#  to_user    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Thank do

  before(:each) do
    @to_user = Factory(:user, :name => 'Fantomas')
    @valid_attributes = {
      :message => "Fantomas is here.",
      :from_user => Factory(:user),
      :to_user => @to_user
    }
  end

  it "creates a new instance given valid attributes" do
    Thank.create!(@valid_attributes)
  end

  it "has got boolean flag group_thanks with default value false" do
    thank = Thank.create!(@valid_attributes)
    thank.group_thanks.should == false
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

      thank = Thank.create({:from_user => @from_user, :message => "Mr. Spock We're rescuing you!"})
      thank.to_user.should == to_user
    end
  end

  it "doesn't save thanks from user 1 to user 1" do
    to_user = Factory(:user, :login => 'spock', :name => 'Mr. Spock')
    thank = Thank.new({:from_user => to_user, :message => "Mr. Spock We're rescuing you!"})
    thank.save.should be_false
  end

  it "delete name from message" do
    from_user = Factory(:user)
    to_user = Factory(:user, :login => 'spock', :name => 'Mr. Spock')
    thank = Thank.create({:from_user => from_user, :message => "Mr. Spock We're rescuing you!"})
    thank.message.should == " We're rescuing you!"
  end

  describe "points for target user" do
    it "are increased by two" do
      from_user = Factory(:user, :name => "mr.awsome")
      user = Factory(:user, :name => "mr.invisible")
      thank = Thank.create({:from_user => from_user, :message => "mr.invisible We can see you!"})

      User.find_by_id(user.id).points.should == 2
    end

    it "are not increased if the target user is same as source user" do
      from_user = Factory(:user, :name => "mr.awsome")
      thank = Thank.create({:from_user => from_user, :message => "mr.awsome is in the town!"})

      User.find_by_id(from_user.id).points.should == 0
    end
  end

  describe "points for source user" do
    it "are increased by one" do
      from_user = Factory(:user, :name => "mr.awsome", :points => 0)
      user = Factory(:user, :name => "mr.invisible")
      Thank.create({:from_user => from_user, :message => "mr.invisible We can see you!", :created_at => 2.days.ago})
      Thank.create({:from_user => from_user, :message => "mr.invisible We can see you!", :created_at => Time.now})

      User.find_by_id(from_user.id).points.should == 2
    end

    it "are not increased if he already thank to someone in that day" do
      from_user = Factory(:user, :name => "mr.awsome", :points => 0)
      user = Factory(:user, :name => "mr.invisible")
      thank = Thank.create({:from_user => from_user, :message => "mr.invisible We can see you!", :created_at => Time.now})
      thank = Thank.create({:from_user => from_user, :message => "mr.invisible We can see you!", :created_at => Time.now})

      User.find_by_id(from_user.id).points.should_not == 2
    end

    it "are not increased if he already thank to someone in that day" do
      from_user = Factory(:user, :name => "mr.awsome", :points => 0)
      user = Factory(:user, :name => "mr.invisible")
      thank = Thank.create({:from_user => from_user, :message => "mr.invisible We can see you!"})

      User.find_by_id(from_user.id).points.should == 1
    end

    it "are not increased if the thank is flaged as grouped" do
      from_user = Factory(:user, :name => "mr.awsome", :points => 0)
      user = Factory(:user, :name => "mr.invisible")
      thank = Thank.create({:from_user => from_user, :message => "mr.invisible We can see you!", :group_thanks => true})

      User.find_by_id(from_user.id).points.should == 0
    end

  end

  describe "user_in_message return" do
    it "user if the name match" do
      thanks = Factory.build(:thank, :message => 'thanks to user 2 he is great.')
      Factory(:user, :name => 'user')
      user2 = Factory(:user, :name => 'user 2')
      Factory(:user, :name => 'user 3')

      thanks.user_in_message.should == user2
    end

    it "users if the name match the group" do
      thanks = Factory.build(:thank, :message => 'thanks to Londoners he is great.')
      user1 = Factory(:user, :name => 'user')
      user2 = Factory(:user, :name => 'user 2')
      user3 = Factory(:user, :name => 'user 3')
      group = Factory(:group, :name => 'Londoners', :users => [user1, user3])

      thanks.user_in_message.should == group
    end

    it "user only if the name match the user and group" do
      thanks = Factory.build(:thank, :message => 'thanks to user 2 he is great.')
      user1 = Factory(:user, :name => 'user')
      user2 = Factory(:user, :name => 'user 2')
      user3 = Factory(:user, :name => 'user 3')
      Factory(:group, :name => 'user 2', :users => [user1, user3])

      thanks.user_in_message.should == user2
    end

    it "false if the name don't match" do
      thanks = Factory.build(:thank, :message => 'thanks to user 2 he is great.')
      Factory(:user, :name => 'user 22')
      user2 = Factory(:user, :name => 'user 23')

      thanks.user_in_message.should be_nil
    end
  end
  
  describe "todays_thanks" do
    before(:each) do
      Factory(:user, :name => 'user 2')
      from_user = Factory(:user, :name => 'user 23')

      @thk1 = Factory(:thank, :created_at => Date.today.to_s(:db), :message => 'thanks to user 2 he is great1.', :from_user => from_user)
      @thk2 = Factory(:thank, :created_at => 1.day.ago, :message => 'thanks to user 2 he is great2.', :from_user => from_user)
      @thk3 = Factory(:thank, :created_at => 2.minutes.ago, :message => 'thanks to user 2 he is great3.', :from_user => from_user)
      @thk4 = Factory(:thank, :created_at => 2.days.ago, :message => 'thanks to user 2 he is great4.', :from_user => from_user)
      @thk5 = Factory(:thank, :created_at => 2.hours.ago, :message => 'thanks to user 2 he is great4.', :from_user => from_user)
    end

    it "returns thanks for today" do
      todays_thanks = Thank.todays_thanks

      todays_thanks.size.should == 3
      todays_thanks.should include(@thk1,  @thk3, @thk5)
    end

    it "doesn't return thanks from other days" do
      todays_thanks = Thank.todays_thanks

      todays_thanks.size.should == 3
      todays_thanks.should_not include(@thk2, @thk4)
    end
  end

  describe "from_user" do
    before(:each) do
      @user1 = Factory(:user, :name => 'user 2')
      @user2 = Factory(:user, :name => 'user 1')

      @thk1 = Factory(:thank, :message => 'thanks to user 2 he is great1.', :from_user => @user2)
      @thk2 = Factory(:thank, :message => 'thanks to user 1 he is great2.', :from_user => @user1)
      @thk3 = Factory(:thank, :message => 'thanks to user 2 he is great3.', :from_user => @user2)
    end

    it "returns all thanks from particular user" do
      users_thanks = Thank.from_user(@user2)

      users_thanks.size.should == 2
      users_thanks.should include(@thk1, @thk3)
    end

    it "doesn't return thanks from different users" do
      users_thanks = Thank.from_user(@user2)

      users_thanks.should_not include(@thk2)
    end
  end

  describe "to_user" do
    before(:each) do
      @user1 = Factory(:user, :name => 'user 1')
      @user2 = Factory(:user, :name => 'user 2')
      @user3 = Factory(:user, :name => 'user 3')

      @thk1 = Factory(:thank, :message => 'thanks to user 2 he is great1.', :from_user => @user3)
      @thk2 = Factory(:thank, :message => 'thanks to user 1 he is great2.', :from_user => @user2)
      @thk4 = Factory(:thank, :message => 'thanks to user 3 he is great2.', :from_user => @user2)
      @thk3 = Factory(:thank, :message => 'thanks to user 2 he is great3.', :from_user => @user1)
    end

    it "returns all thanks to particular user" do
      users_thanks = Thank.to_user(@user2)

      users_thanks.size.should == 2
      users_thanks.should include(@thk1, @thk3)
    end

    it "doesn't return thanks to different users" do
      users_thanks = Thank.to_user(@user2)

      users_thanks.should_not include(@thk2, @thk4)
    end
  end

  describe "thanks_from" do
    before(:each) do
      Factory(:user, :name => 'user 2')
      from_user = Factory(:user, :name => 'user 23')

      @thk1 = Factory(:thank, :created_at => "2010-11-07 12:45:00", :message => 'thanks to user 2 he is great1.', :from_user => from_user)
      @thk2 = Factory(:thank, :created_at => "2010-11-06 12:45:00", :message => 'thanks to user 2 he is great2.', :from_user => from_user)
      @thk3 = Factory(:thank, :created_at => "2010-11-07 12:40:00", :message => 'thanks to user 2 he is great3.', :from_user => from_user)
      @thk4 = Factory(:thank, :created_at => "2010-11-05 12:44:00", :message => 'thanks to user 2 he is great4.', :from_user => from_user)
      @thk5 = Factory(:thank, :created_at => "2010-11-07 10:44:00", :message => 'thanks to user 2 he is great4.', :from_user => from_user)
    end

    it "returns thanks from specific date" do
      thanks = Thank.thanks_from("2010-11-06 12:45:00")

      thanks.size.should == 4
      thanks.should include(@thk1, @thk2, @thk3, @thk5)
    end

    it "doesn't return thanks older than specific date" do
      thanks = Thank.thanks_from("2010-11-06 12:45:00")

      thanks.size.should == 4
      thanks.should_not include(@thk4)
    end
    
  end
end
