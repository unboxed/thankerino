@PT_4696687
@PT_4696687
@PT_4696684

Feature: Manage thanks
  In order to say thank you
  as a user
  I wants post my thank you message easily on the wall

  Background:
     Given a user "petr" exists with name: "Clark Kent", login: "superman", email: "superman@crypton.com", password: "supersecret", points: 0
     And I am logged in as "petr" with password "supersecret" and email "petr@petr.com"

  Scenario: Posting new thank you message
    Given I am on the home page
      And I should see "recent appreciation" image
      And I fill in "thank_message" with "Clark Kent for saving the world."
      And I press "Thanks"
    Then I should see "Thanks to Clark Kent for saving the world. By petr"
      And I should be on the home page

  Scenario: Looking at scoreboard
    Given a user exists with name: "Jan Opletal", points: 4, email: "jan@test.com", password: "supersecret" 
      And a user exists with name: "Tom Opletal", points: 10, email: "tom@test.com", password: "supersecret" 
      And a user exists with name: "Petr Opletal", points: 2, email: "petr@test.com", password: "supersecret"
      And I am on the scoreboard page
      And I should see "Tom Opletal: 10 points" no. 1 in the list
      And I should see "Jan Opletal: 4 points" no. 2 in the list
      And I should see "Petr Opletal: 2 points" no. 3 in the list
@test
  Scenario: Posting new thank you message for group
    Given a user "user1" exists with name: "Jan Opletal", points: 4, email: "jan@test.com", password: "supersecret" 
      And a user "user2" exists with name: "Tom Opletal", points: 10, email: "tom@test.com", password: "supersecret" 
      And a user "user3" exists with name: "Petr Opletal", points: 2, email: "petr@test.com", password: "supersecret"
      And a group exist with name "londoners" and user "jan@test.com" and user "tom@test.com"
    Then I am on the home page
      And I should see "recent appreciation" image
      And I fill in "thank_message" with "londoners for being so great."
      And I press "Thanks"
    Then I should see "londoners for being so great."
      And I should be on the home page
      And user "jan@test.com" should has "6" point
      And user "tom@test.com" should has "12" point
