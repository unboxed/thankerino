Given /^I am logged in as "([^"]*)" with password "([^"]*)" and email "([^"]*)"$/ do |login, password, email|
  User.create!(:name => "#{login}", :login => "#{login}", :password => "#{password}", :email =>"#{email}") unless User.find_by_login(login)

  visit new_user_session_url
  fill_in('Email', :with => email)
  fill_in("Password", :with => password)
  click_button("Login")
end

Given /^I should see "([^"]*)" in the main menu$/ do |menu_item|
  page.should have_xpath(".//*[@id='menu']/ul/li/a/img[@alt='#{menu_item}']")
end

Given /^I should see "([^"]*)" in the footer menu$/ do |menu_item|
  page.should have_xpath(".//*[@id='footer_menu']/ul/li/a/img[@alt='#{menu_item}']")
end

Given /^I should see "([^"]*)" in the points history section$/ do |expected_text|
  page.should have_xpath("//*[@class='thanks_history']/li[contains(.,\"#{expected_text}\")]")
end

Given /^I should see "([^"]*)" image$/ do |image_alt|
  page.should have_xpath(".//img[@alt='#{image_alt}']")
end
