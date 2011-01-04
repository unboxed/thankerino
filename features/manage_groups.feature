Feature: Manage groups
  In order to add group users
  As an admin
  I want to simple interface for that

  Scenario: As an admin I am able to create groups
    Given a user "petr" exists with login: "petr", name: "Petr Zaparka", role: 1, email: "petr.zaparka@unboxedconsulting.com", password: "supersecret", password_confirmation: "supersecret"
      And a user "tom" exist with name: "Tom Danger", role: 0, email: "tom.danger@unboxedconsulting.com"
      And I am logged in as "petr" with password "supersecret" and email "petr.zaparka@unboxedconsulting.com"
      And I am on the groups page
      And I should see "Groups"
    When I follow "Create group"
    Then I should see "New group"
      And I fill in "Group's name" with "London"
      And I check "Petr Zaparka"
      And I check "Tom Danger"
      And I press "Create group"
    Then I should see "Group was successfully created"
     And I should see "London"
     And I should see "2"

