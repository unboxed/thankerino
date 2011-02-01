Feature: Administration
  In order to have administration tools
  As an admin
  I want to have administration

  Scenario: As an admin I am able to see administration
    Given a user "petr" exists with login: "petr", role: 1, email: "petr.zaparka@unboxedconsulting.com", password: "supersecret", password_confirmation: "supersecret"
      And I am logged in as "petr" with password "supersecret" and email "petr.zaparka@unboxedconsulting.com"
      And I am on the profile page of petr
      And I should see "Administration"
    When I follow "Administration"
    Then I should be on the administration page
      And I should see "Users"
      And I should see "Groups"
      And I should see "Delete points"

  Scenario: As an user I am unable to see administration
    Given a user "petr" exists with login: "petr", email: "petr.zaparka@unboxedconsulting.com", password: "supersecret", password_confirmation: "supersecret"
      And I am logged in as "petr" with password "supersecret" and email "petr.zaparka@unboxedconsulting.com"
      And I am on the profile page of petr
      And I should not see "Administration"
    When I go to the administration page
    Then I should not see "users import"
      And I am on the profile page of petr
@wp
  Scenario: As an admin I am able to import users
    Given a user "petr" exists with login: "petr", role: 1, email: "petr.zaparka@unboxedconsulting.com", password: "supersecret", password_confirmation: "supersecret"
      And I am logged in as "petr" with password "supersecret" and email "petr.zaparka@unboxedconsulting.com"
      And I am on the administration page
      And I should see "Users"
    When I follow "Users"
    Then I should see "Select CSV file:"
      And I assign "gmail.csv" csv file
      And I press "import"
    Then I should see "Import successful"

  Scenario: As an admin I am able to add single user
    Given a user "petr" exists with login: "petr", role: 1, email: "petr.zaparka@unboxedconsulting.com", password: "supersecret", password_confirmation: "supersecret"
      And I am logged in as "petr" with password "supersecret" and email "petr.zaparka@unboxedconsulting.com"
      And I am on the administration page
      And I should see "Users"
    When I follow "Users"
    Then I should see "Add single user"
      And I fill in "Name" with "Petr Parker"
      And I fill in "Email" with "petr.parker@ubxd.com"
      And I press "Add user"
    Then I should see "User created"

  Scenario: As an admin I am able to reset score
    Given a user "petr" exists with login: "petr", role: 1, email: "petr.zaparka@unboxedconsulting.com", password: "supersecret", password_confirmation: "supersecret"
      And I am logged in as "petr" with password "supersecret" and email "petr.zaparka@unboxedconsulting.com"
      And I am on the profile page of petr
      And I should see "Administration"
    When I follow "Administration"
    Then I should be on the administration page
      And I should see "Users"
      And I should see "Groups"
      And I should see "Delete points"
    When I follow "Delete points"
    Then I should see "All points deleted."
