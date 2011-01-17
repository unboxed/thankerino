@PT_4696675

Feature: Navigation
  In order to have friendly UX
  as a User
  I want to see navigation

  Scenario: Main menu
    Given a user "petr" exists with login: "petr", email: "petr.zaparka@unboxedconsulting.com", password: "supersecret", password_confirmation: "supersecret"
      And I am logged in as "petr" with password "supersecret" and email "petr.zaparka@unboxedconsulting.com"
      And I am on the home page
      And I should see "home" in the main menu
      And I should see "me" in the main menu
      And I should see "scoreboard" in the main menu
      And I should see "community" in the main menu

      And I should see "home" in the footer menu
      And I should see "me" in the footer menu
      And I should see "scoreboard" in the footer menu
      And I should see "community" in the footer menu

  Scenario: Scoreboerd
    Given a user "petr" exists with login: "petr", name: "Petr Zaparka", email: "petr.zaparka@unboxedconsulting.com", password: "supersecret", password_confirmation: "supersecret", points: "4"
      And a user "tom" exists with login: "tom", name: "Tom Danger"
      And a thank "3" exists with to_user: user "petr", from_user: user "tom", message: "Petr Zaparka for this awesome app"
      And I am logged in as "petr" with password "supersecret" and email "petr.zaparka@unboxedconsulting.com"
      And I am on the home page
      And I follow "scoreboard"
    Then I should see "Petr Zaparka"
      And I should see "Tom Danger"

  Scenario: Community as user
    Given a user "petr" exists with login: "petr", name: "Petr Zaparka", email: "petr.zaparka@unboxedconsulting.com", password: "supersecret", password_confirmation: "supersecret", points: "4"
      And a scoreboard exist with name: "December winner Petr Zaparka"
      And I am logged in as "petr" with password "supersecret" and email "petr.zaparka@unboxedconsulting.com"
      And I am on the home page
      And I follow "community"
      And I should be on the scoreboards page
    Then I should see "December winner Petr Zaparka"
      And I should not see "New Score"
      And I should not see "Edit"

  Scenario: Community as admin
    Given a user "petr" exists with login: "petr", name: "Petr Zaparka", role: 1, email: "petr.zaparka@unboxedconsulting.com", password: "supersecret", password_confirmation: "supersecret", points: "4"
      And a scoreboard exist with name: "December winner Petr Zaparka"
      And I am logged in as "petr" with password "supersecret" and email "petr.zaparka@unboxedconsulting.com"
      And I am on the home page
      And I follow "community"
      And I should be on the scoreboards page
    Then I should see "December winner Petr Zaparka"
      And I should see "New Score"
      And I should see "Edit"

