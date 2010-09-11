# @PT_4696687
# @PT_4696687
# @PT_4696684
# 
# Feature: Manage thanks
#   In order to say thank you
#   as a user
#   I wants post my thank you message easily on the wall
# 
#   Background:
#      Given I am logged in as "petr" with password "supersecret"
#      And a user "petr" exists with login: "clark", email: "superman@unboxedconsulting.com", password: "supersecret", password_confirmation: "supersecret", name: "Clark Kent"
# 
#   Scenario: Posting new thank you message
#     Given I am on the home page
#       And I fill in "Thanks to" with "#superman for saving the world."
#       And I press "Thanks"
#     Then I should see "Thanks to Clark Kent for saving the world."
#       And I should be on the home page
# 
#   Scenario: Posting new thank you message no longer than 100 characters
#     Given I am on the home page
#       And I fill in "Thank you" with "Thank you to Academy for Oscar and thanks to my family for supporting me. And of course thanks to Director."
#       And I press "Thanks"
#     Then I should not see "Thank you to Academy for Oscar and thanks to my family for supporting me. And of course thanks to Director."
#       And I should see "Message is too long (maximum is 100 characters)."
#   
#   Scenario: Posting new thank you message is displayed properly
#     Given I am on the home page
#       And a thank exists with message: "Thank you #petr.zaparka for this great app"
#       And a thank exists with message: "Thank you #petr.zaparka"
#       And I fill in "Thank you" with "Thank you #superman for saving the world."
#       And I press "Thanks"
#     Then I should see "Thank you Clark Kent for saving the world."
#       And I should be on the home page
#       And I should see the following thanks:
#       | Message                                    |
#       | Thank you Clark Kent for saving the world. |
#       | Thank you petr.zaparka                     |
#       | Thank you petr.zaparka for this great app  |
#   
