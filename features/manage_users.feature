@PT_4696675

Feature: Manage users
  In order to handle users data
  as a User
  I want to have easy registration and editing process

  Scenario: Register new user
    Given I am on the registration page
      And I should see "Register"
      And I fill in "Login" with "petr"
      And I fill in "Email" with "petr.zaparka@unboxedconsulting.com"
      And I fill in "Password" with "supersecret"
      And I fill in "Password confirmation" with "supersecret"
      And I should not see "Current password"
      And I press "Register"
    Then I should see "Account registered!"

  Scenario: Login user
    Given a user "petr" exists with login: "petr", email: "petr.zaparka@unboxedconsulting.com", password: "supersecret", password_confirmation: "supersecret"
      And I am on the login page
      And I should see "Login"
      And I fill in "Login" with "petr"
      And I fill in "Password" with "supersecret"
      And I press "Login"
    Then I should see "Login successful!"

  Scenario: Edit user name and email
    Given a user "petr" exists with login: "petr", email: "petr.zaparka@unboxedconsulting.com", password: "supersecret", password_confirmation: "supersecret"
      And I am logged in as "petr" with password "supersecret"
      And I am on the user profile page
      And I fill in "Name" with "Petr Zaparka"
      And I fill in "Login" with "pet12r"
      And I fill in "Email" with "petr@zaparka.cz"
      And I press "Update"
    Then I should see "Account updated!"
      And I should see "Name: Petr Zaparka"
      And I should see "Login: pet12r"
      And I should see "Email: petr@zaparka.cz"