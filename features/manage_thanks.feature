@PT_4696687
@PT_4696687
@PT_4696684

Feature: Manage thanks
  In order to say thank you
  as a user
  I wants post my thank you message easily on the wall

  Background:
     Given a user "petr" exists with login: "superman", email: "superman@crypton.com", password: "supersecret", password_confirmation: "supersecret", name: "Clark Kent"
     And I am logged in as "petr" with password "supersecret"

  Scenario: Posting new thank you message
    Given I am on the home page
      And I fill in "Thanks to" with "#superman for saving the world."
      And I press "Thanks"
    Then I should see "Thanks to Clark Kent for saving the world."
      And I should be on the home page
