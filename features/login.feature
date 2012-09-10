Feature: Login

  Scenario: Login
    Given I am at login page
    When I login as zeljko.filipin@gmail.com
    Then I should see feedback Signed in successfully.
