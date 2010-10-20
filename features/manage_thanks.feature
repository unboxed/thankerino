@PT_4696687
@PT_4696687
@PT_4696684

Feature: Manage thanks
  In order to say thank you
  as a user
  I wants post my thank you message easily on the wall

  Background:
     Given a user "petr" exists with name: "Clark Kent", login: "superman", email: "superman@crypton.com", password: "supersecret", password_confirmation: "supersecret"
     And I am logged in as "petr" with password "supersecret" and email "petr@petr.com"

  Scenario: Posting new thank you message
    Given I am on the home page
      And I should see "RECENT APPRECIATION:"
      And I fill in "THANKS TO..." with "Clark Kent for saving the world."
      And I press "Thanks"
    Then I should see "Thanks to Clark Kent for saving the world. By petr"
      And I should be on the home page
