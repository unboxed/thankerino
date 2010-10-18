Given /^I am logged in as "([^"]*)" with password "([^"]*)" and email "([^"]*)"$/ do |login, password, email|
  User.create!(:name => "#{login}", :login => "#{login}", :password => "#{password}", :email =>"#{email}") unless User.find_by_login(login)

  visit new_user_session_url
  fill_in('Email', :with => email)
  fill_in("Password", :with => password)
  click_button("Login")
end

Given /^I should see "([^"]*)" in the main menu$/ do |menu_item|
  page.should have_xpath("//*[@id='menu']/a[contains(., \"#{menu_item}\")]")
end

Given /^I should see "([^"]*)" in the footer menu$/ do |menu_item|
  page.should have_xpath("//*[@id='footer_menu']/a[contains(., \"#{menu_item}\")]")
end

Given /^I should see "([^"]*)" in the points history section$/ do |expected_text|
  page.should have_xpath("//*[@id='thanks_history']/ul/li[contains(., \"#{expected_text}\")]")
end
