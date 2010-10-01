@PT_4696675

Feature: Navigation
  In order to have friendly UX
  as a User
  I want to see navigation

  Scenario: Main menu
    Given a user "petr" exists with login: "petr", email: "petr.zaparka@unboxedconsulting.com", password: "supersecret", password_confirmation: "supersecret"
      And I am logged in as "petr" with password "supersecret"
      And I am on the home page
      And I should see "HOME" in the main menu
      And I should see "ME" in the main menu
      And I should see "SCOREBOARD" in the main menu
      And I should see "COMMUNITY" in the main menu

      And I should see "HOME" in the footer menu
      And I should see "ME" in the footer menu
      And I should see "SCOREBOARD" in the footer menu
      And I should see "COMMUNITY" in the footer menu

  Scenario: Community
    Given a user "petr" exists with login: "petr", name: "Petr Zaparka", email: "petr.zaparka@unboxedconsulting.com", password: "supersecret", password_confirmation: "supersecret", points: "4"
      And a user "tom" exists with login: "tom", name: "Tom Danger"
      And a thank "3" exists with to_user: user "petr", from_user: user "tom", message: "Petr Zaparka for this awesome app"
      And I am logged in as "petr" with password "supersecret"
      And I am on the home page
      And I follow "COMMUNITY"
    Then I should see "Petr Zaparka"
      And I should see "Tom Danger"
