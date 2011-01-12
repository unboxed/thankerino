Then /^I should see the groups:$/ do |grouptable|
  grouptable.diff!(tableish('table tr', 'td,th'))
end

Given /^a group exist with name "([^"]*)" and user "([^"]*)" and user "([^"]*)"$/ do |group_name, user1, user2|
  usr1 = User.find_by_email(user1)
  usr2 = User.find_by_email(user2)
  Group.create!({:name => group_name, :users => [usr1, usr2]})
end

Then /^user "([^"]*)" should has "([^"]*)" point$/ do |user_mail, points|
  User.find_by_email(user_mail).points.should == points.to_i
end

