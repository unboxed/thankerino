When /^I should see "([^\"]*)" picture field$/ do |field_name|
  page.should have_xpath("//input[@name='user[#{field_name}]']")
end

Then /^I upload the picture "([^\"]*)"$/ do |picture_name|
  attach_file('user[avatar]', File.join(Rails.root, 'spec', 'assets', picture_name))
end

Then /^I should see a profile picture "([^\"]*)" with style "([^\"]*)"$/ do |image_name, style_name|
  postfix = image_name.split('.').last
  page.should have_xpath("//img[contains(@src, '#{style_name}.#{postfix}')]")
end

Then /^I should not see a profile picture "([^\"]*)"$/ do |image_name|
  page.should_not have_xpath("//img[contains(@src, '#{image_name}')]")
end

Then /^I (should(?: not)?) see the default profile picture$/ do |expectation|
  case expectation
   when "should"
     page.should have_xpath("//img[contains(@src, 'missing_medium.jpg') or contains(@src, 'missing_thumb.jpg')]")
   else
     page.should_not have_xpath("//img[contains(@src, 'missing_medium.jpg') or contains(@src, 'missing_thumb.jpg')]")
   end
end

Given /^profile for "([^\"]*)" with picture "([^\"]*)"$/ do |login, image_name|
  img_path = File.join(Rails.root, 'features', 'upload-files', image_name)
  Person.find_by_login(login).update_attribute(:avatar, File.new(img_path, "r"))
end

