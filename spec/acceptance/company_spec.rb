require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Company", %q{
  In order to manage companies
  As an admin
  I want to CRUD functionality
} do

  background do
    user = Factory(:user, :role => User::ROLE[:admin], :password => "Supersecret1", :password_confirmation => "Supersecret1")
    visit new_user_session_url
    fill_in('user_email', :with => user.email)
    fill_in("user_password", :with => 'Supersecret1')
    click_button('user_submit')
  end

  scenario "Adding company" do
    visit admin_path
    page.should have_content('Companies')
    click_link 'Companies'
    page.should have_content('Listing companies')
    click_link 'New Company'

    fill_in('company_name', :with => "Unboxed")
    click_button('Create Company')
    current_url.should == companies_url
    page.should have_content('Unboxed')
  end
end
