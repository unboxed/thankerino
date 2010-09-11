Given /^I am logged in as "([^"]*)" with password "([^"]*)"$/ do |login, password|
  User.create!(:login => 'petr2', :password => 'suoperboasas', :password_confirmation => 'suoperboasas', :email =>'test@test.com') unless User.find_by_login(login)
  visit new_user_session_url
  fill_in('Login', :with => login)
  fill_in("Password", :with => password)
  click_button("Login")
end